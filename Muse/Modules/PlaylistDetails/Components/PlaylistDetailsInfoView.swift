//
//  PlaylistDetailsInfoView.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 09.02.2024.
//

import SwiftUI
import MusicKit

extension PlaylistDetailsView {
    
    struct InfoView: View {
        private let playlist: Playlist
        
        @EnvironmentObject private var musicManager: MusicManager
        @EnvironmentObject private var musicPlayer: MusicPlayer
        
        init(playlist: Playlist) {
            self.playlist = playlist
        }
        
        var body: some View {
            HStack(alignment: .bottom, spacing: 24.0) {
                MusicArtworkImage(artwork: self.playlist.artwork, width: 256.0, height: 256.0)
                    .frame(width: 256.0, height: 256.0)
                    .clipShape(.rect(cornerRadius: 12.0))
                    .glow(
                        using: .init(
                            color: Color(cgColor: self.playlist.artwork?.backgroundColor ?? .black),
                            radius: 16.0,
                            duration: 8.0
                        )
                    )
                
                VStack(alignment: .leading, spacing: 64.0) {
                    self.info
                    self.buttons
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 256.0)
        }
        
        // MARK: - Components
        
        private var info: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                VStack(alignment: .leading, spacing: 8.0) {
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text(self.playlist.title)
                            .font(.system(size: 24.0, weight: .bold))
                            .foregroundStyle(Color.primaryText)
                        
                        if let curatorName = self.playlist.curatorName {
                            Text(curatorName)
                                .font(.system(size: 20.0, weight: .regular))
                                .foregroundStyle(Color.pinkAccent)
                        }
                    }
                    
                    if let updatedDate = self.playlist.lastModifiedDate?.formatted(.relative(presentation: .named)) {
                        Text("UPDATED \(updatedDate.uppercased())")
                            .font(.system(size: 12.0, weight: .bold))
                            .foregroundStyle(Color.secondaryText)
                    }
                }
                
                if let description = self.playlist.curator?.editorialNotes?.standard {
                    Text(description)
                        .font(.system(size: 18.0, weight: .regular))
                        .foregroundStyle(Color.secondaryText)
                }
            }
        }
        
        private var buttons: some View {
            HStack {
                HStack(spacing: 4.0) {
                    Button {
                        Task {
                            await self.musicPlayer.play(item: self.playlist)
                        }
                    } label: {
                        HStack(spacing: 4.0) {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .frame(width: 128.0)
                    }
                    .buttonStyle(.app(.primary))
                    
                    Button {
                        Task {
                            await self.musicPlayer.play(item: self.playlist, shuffleMode: .songs)
                        }
                    } label: {
                        HStack(spacing: 4.0) {
                            Image(systemName: "shuffle")
                            Text("Shuffle")
                        }
                        .frame(width: 128.0)
                    }
                    .buttonStyle(.app(.secondary))
                }
                
                Spacer()
            }
        }
    }
    
}
