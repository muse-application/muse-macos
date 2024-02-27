//
//  AlbumDetailsInfoView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 30.01.2024.
//

import SwiftUI
import MusicKit

extension AlbumDetailsView {
    
    struct InfoView: View {
        private let album: Album
        
        @Environment(\.openURL) private var openURL
        
        @EnvironmentObject private var musicPlayer: MusicPlayer
        @EnvironmentObject private var router: Router
        
        init(album: Album) {
            self.album = album
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                VStack(alignment: .leading, spacing: 12.0) {
                    MusicArtworkImage(artwork: self.album.artwork, width: 256.0, height: 256.0)
                        .clipShape(.rect(cornerRadius: 12.0))
                        .glow(
                            using: .init(
                                color: Color(cgColor: self.album.artwork?.backgroundColor ?? .black),
                                radius: 16.0,
                                duration: 8.0
                            )
                        )
                    
                    self.info
                }
                
                self.buttons
                self.copyright
            }
            .frame(width: 256.0)
        }
        
        // MARK: - Components
        
        private var info: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4.0) {
                        Text(self.album.title)
                            .font(.system(size: 18.0, weight: .bold))
                            .foregroundStyle(Color.primaryText)
                        
                        if let artists = self.album.artists {
                            self.artistsLabel(for: artists)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.system(size: 24.0))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color.pinkAccent)
                    }
                    .buttonStyle(.plain)
                }
                .zIndex(1)
                
                Text(self.albumInfoText())
                    .font(.system(size: 12.0, weight: .bold))
                    .foregroundColor(Color.secondaryText)
                
                if let description = self.album.editorialNotes?.short {
                    Text(description)
                        .lineLimit(3)
                        .font(.system(size: 14.0, weight: .regular))
                        .foregroundStyle(Color.secondaryText)
                }
            }
        }
        
        private var buttons: some View {
            HStack(spacing: 4.0) {
                Button {
                    self.musicPlayer.play(item: self.album)
                } label: {
                    HStack(spacing: 4.0) {
                        Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.app(.primary))
                
                Button {
                    self.musicPlayer.play(item: self.album, shuffleMode: .songs)
                } label: {
                    HStack(spacing: 4.0) {
                        Image(systemName: "shuffle")
                        Text("Shuffle")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.app(.secondary))
            }
        }
        
        private var copyright: some View {
            VStack(alignment: .leading, spacing: 4.0) {
                if let recordLabelName = self.album.recordLabelName {
                    Text(recordLabelName)
                        .font(.system(size: 10.0, weight: .semibold))
                        .foregroundStyle(Color.secondaryText)
                }
                
                if let copyright = self.album.copyright {
                    Text(copyright)
                        .font(.system(size: 10.0, weight: .regular))
                        .foregroundStyle(Color.secondaryText)
                }
            }
        }
        
        @ViewBuilder
        private func artistsLabel(for artists: MusicItemCollection<Artist>) -> some View {
            if artists.count == 1 {
                NavigationLink(value: artists.first) {
                    Text(self.album.artistName)
                        .font(.system(size: 16.0, weight: .medium))
                        .foregroundStyle(Color.pinkAccent)
                }
                .buttonStyle(.plain)
            } else {
                Text(self.artistsText(for: artists))
                    .font(.system(size: 16.0, weight: .medium))
                    .foregroundStyle(Color.pinkAccent)
                    .environment(\.openURL, OpenURLAction { url in
                        guard let selectedArtist = artists.first(where: { url.absoluteString == $0.id.rawValue }) else {
                            return .handled
                        }
                        
                        self.router.push(selectedArtist)
                        
                        return .handled
                    })
            }
        }
        
        private func artistsText(for artists: MusicItemCollection<Artist>) -> AttributedString {
            var result: AttributedString = .init()
            
            for artist in artists {
                var text = AttributedString("\(artist.name)")
                text.link = URL(string: artist.id.rawValue)
                text.foregroundColor = .pinkAccent
                
                result.append(text)
                
                if artist != artists.last {
                    let separator = AttributedString(" & ")
                    result.append(separator)
                }
            }
            
            return result
        }
        
        private func albumInfoText() -> String {
            var info: [String] = .init()
            
            if let genre = self.album.genreNames.first {
                info.append(genre.uppercased())
            }
            
            if let releaseYear = self.album.releaseDate?.format("YYYY") {
                info.append(releaseYear)
            }
            
            return info.joined(separator: " • ")
        }
    }
    
}
