//
//  GroupedSongItemStyle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 16.01.2024.
//

import SwiftUI
import MusicKit

struct GroupedSongItemStyle: SongItemStyle {
    private let position: Int
    
    init(position: Int) {
        self.position = position
    }
    
    func content(for song: Song, context: SongItemContext) -> some View {
        HStack(spacing: 16.0) {
            ZStack {
                if context.isHovered {
                    Image(systemName: "play.fill")
                        .foregroundStyle(Color.pinkAccent)
                } else {
                    Text("\(self.position)")
                        .foregroundStyle(Color.secondaryText)
                }
            }
            .font(.system(size: 14.0, weight: .bold))
            .frame(width: 20.0, height: 16.0)
            
            Text(song.title)
                .lineLimit(1)
                .font(.system(size: 14.0, weight: .regular))
                .foregroundStyle(Color.primaryText)
            
            Spacer()
            
            if let duration = song.duration?.minutesAndSeconds {
                Text(duration)
                    .font(.system(size: 14.0, weight: .medium))
                    .foregroundStyle(Color.secondaryText)
                    .frame(width: 40.0)
            }
        }
        .padding(.all, 16.0)
        .background {
            if context.isHovered {
                Color.primaryFill.opacity(0.1)
            } else {
                if self.position % 2 == 0 {
                    Color.clear
                } else {
                    Color.primaryFill.opacity(0.04)
                }
            }
        }
        .clipShape(.rect(cornerRadius: 8.0))
    }
    
    func skeleton() -> some View {
        VStack {
            
        }
    }
}

extension SongItemStyle where Self == GroupedSongItemStyle {
    static func grouped(at position: Int) -> GroupedSongItemStyle {
        return .init(position: position)
    }
}
