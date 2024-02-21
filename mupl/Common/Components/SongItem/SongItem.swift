//
//  SongItem.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import SwiftUI
import MusicKit

struct SongItem<S: SongItemStyle>: View {
    private let song: Song
    private let style: S
    
    @EnvironmentObject private var musicPlayer: MusicPlayer
    
    @State private var isHovered: Bool = false
    
    init(song: Song, style: S = .plain) {
        self.song = song
        self.style = style
    }
    
    var body: some View {
        self.style.content(
            for: self.song,
            context: .init(
                isCurrent: self.musicPlayer.currentSong == self.song,
                isHovered: self.isHovered
            )
        )
        .onHover { hovering in
            self.isHovered = hovering
        }
        .onTapGesture {
            self.musicPlayer.play(item: self.song)
        }
    }
}

// MARK: - Skeleton

extension SongItem {
    struct Skeleton: View {
        private let style: S
        
        init(style: S = .plain) {
            self.style = style
        }
        
        var body: some View {
            self.style.skeleton()
        }
    }
}
