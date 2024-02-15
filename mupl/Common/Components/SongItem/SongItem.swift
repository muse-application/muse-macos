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
    
    @State private var isHovered: Bool = false
    
    init(song: Song, style: S = .plain) {
        self.song = song
        self.style = style
    }
    
    var body: some View {
        self.style.content(for: song, context: .init(isHovered: self.isHovered))
            .onHover { hovering in
                self.isHovered = hovering
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
