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
        
        init(album: Album) {
            self.album = album
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                VStack(alignment: .leading, spacing: 12.0) {
                    MusicArtworkImage(artwork: self.album.artwork)
                        .frame(width: 256.0, height: 256.0)
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
                        
                        Text(self.album.artistName)
                            .font(.system(size: 16.0, weight: .medium))
                            .foregroundStyle(Color.pinkAccent)
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
                
                HStack(spacing: 2.0) {
                    if let genre = self.album.genreNames.first {
                        Text(genre.uppercased())
                    }
                    
                    if let releaseYear = self.album.releaseDate?.format("YYYY") {
                        Text("•")
                        Text(releaseYear)
                    }
                }
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
                    
                } label: {
                    HStack(spacing: 4.0) {
                        Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.app(.primary))
                
                Button {
                    
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
    }
    
}
