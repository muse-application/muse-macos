//
//  PlaybarSongPreview.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI
import MusicKit

struct PlaybarSongPreview: View {
    @EnvironmentObject private var musicPlayer: MusicPlayer
    @EnvironmentObject private var router: Router
    
    var body: some View {
        Group {
            if let currentSong = self.musicPlayer.currentSong {
                self.content(currentSong)
            } else {
                self.emptyContent
            }
        }
        .frame(minWidth: 240.0)
    }
    
    private var emptyContent: some View {
        HStack(spacing: 12.0) {
            Color.secondaryFill
                .frame(width: 36.0, height: 36.0)
                .clipShape(.rect(cornerRadius: 8.0))
                .border(style: .quinaryFill, cornerRadius: 8.0)
            
            Text("No song to play")
                .font(.system(size: 12.0, weight: .semibold))
                .foregroundStyle(Color.primaryText)
        }
    }
    
    private func content(_ song: Song) -> some View {
        HStack(spacing: 12.0) {
            MusicArtworkImage(artwork: song.artwork, width: 36.0, height: 36.0)
                .clipShape(.rect(cornerRadius: 8.0))
                .border(style: .quinaryFill, cornerRadius: 8.0)
            
            VStack(alignment: .leading, spacing: 0.0) {
                Text(song.title)
                    .font(.system(size: 12.0, weight: .semibold))
                    .foregroundStyle(Color.primaryText)
                
                Text(song.artistName)
                    .font(.system(size: 10.0, weight: .medium))
                    .foregroundStyle(Color.secondaryText)
            }
        }
        .tappable(hoverStyle: .init(padding: .init(vertical: 8.0, horizontal: 12.0), cornerRadius: 8.0)) {
            self.router.push(song)
        }
    }
}
