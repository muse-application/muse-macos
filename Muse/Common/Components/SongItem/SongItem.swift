//
//  SongItem.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import SwiftUI
import MusicKit

struct SongItem<S: SongItemStyle>: View {
    private let song: Song
    private let style: S
    
    @EnvironmentObject private var musicPlayer: MusicPlayer
    
    @State private var isCurrent: Bool = false
    @State private var isCurrentlyPlaying: Bool = false
    @State private var isHovered: Bool = false
    
    init(song: Song, style: S = .plain) {
        self.song = song
        self.style = style
    }
    
    var body: some View {
        self.style.content(
            for: self.song,
            context: .init(
                isCurrent: self.isCurrent,
                isCurrentlyPlaying: self.isCurrentlyPlaying,
                isHovered: self.isHovered
            )
        )
        .onAppear {
            self.isCurrent = self.musicPlayer.currentSong?.id == self.song.id
            self.isCurrentlyPlaying = self.isCurrent && self.musicPlayer.playbackState == .playing
        }
        .onChange(of: self.musicPlayer.currentSong) { _, value in
            self.isCurrent = value?.id == self.song.id
        }
        .onChange(of: self.musicPlayer.playbackState) { _, value in
            self.isCurrentlyPlaying = self.isCurrent && value == .playing
        }
        .onHover { hovering in
            self.isHovered = hovering
        }
        .onTapGesture {
            Task {
                if self.isCurrentlyPlaying {
                    self.musicPlayer.pause()
                } else if self.isCurrent {
                    await self.musicPlayer.play()
                } else {
                    await self.musicPlayer.play(item: self.song)
                }
            }
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
