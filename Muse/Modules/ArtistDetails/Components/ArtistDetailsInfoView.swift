//
//  ArtistDetailsInfoView.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

extension ArtistDetailsView {
    struct InfoView: View {
        private let artist: Artist
        
        @EnvironmentObject private var musicPlayer: MusicPlayer
        
        init(artist: Artist) {
            self.artist = artist
        }
        
        var body: some View {
            HStack {
                HStack(spacing: 16.0) {
                    MusicArtworkImage(artwork: self.artist.artwork, width: 80.0, height: 80.0)
                        .clipShape(.rect(cornerRadius: 40.0))
                    
                    VStack(alignment: .leading, spacing: 0.0) {
                        if let genres = self.artist.genreNames?.joined(separator: "●").uppercased() {
                            Text(genres)
                                .font(.system(size: 12.0, weight: .bold))
                                .foregroundStyle(Color.secondaryText)
                        }
                        
                        Text(self.artist.name)
                            .font(.system(size: 24.0, weight: .semibold))
                            .foregroundStyle(Color.primaryText)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 12.0) {
                    Button {
                        Task {
                            if let topSongs = self.artist.topSongs {
                                await self.musicPlayer.play(songs: .init(topSongs), shuffleMode: .songs)
                            }
                        }
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 24.0))
                            .symbolRenderingMode(.multicolor)
                            .foregroundStyle(Color.pinkAccent)
                    }
                    .buttonStyle(.plain)
                    .disabled(self.artist.topSongs == nil)
                    
                    Color.quinaryFill
                        .frame(width: 4.0, height: 16.0)
                        .clipShape(.rect(cornerRadius: 2.0))
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.system(size: 24.0))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color.pinkAccent)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
