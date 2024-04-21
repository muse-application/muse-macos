//
//  PlainSongItemStyle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 16.01.2024.
//

import SwiftUI
import MusicKit

struct PlainSongItemStyle: SongItemStyle {
    func content(for song: Song, context: SongItemContext) -> some View {
        VStack {
            HStack {
                HStack(spacing: 12.0) {
                    ZStack {
                        MusicArtworkImage(artwork: song.artwork, width: 40.0, height: 40.0)
                        
                        Group {
                            if context.isHovered {
                                ZStack {
                                    Color.black
                                        .opacity(0.4)
                                    
                                    Image(systemName: context.isCurrentlyPlaying ? "pause.fill" : "play.fill")
                                        .font(.system(size: 14.0, weight: .regular))
                                        .foregroundStyle(Color.white)
                                }
                            } else if context.isCurrent {
                                ZStack {
                                    Color.black
                                        .opacity(0.4)
                                    
                                    Image(systemName: "waveform")
                                        .font(.system(size: 14.0))
                                        .foregroundStyle(Color.white)
                                        .symbolEffect(
                                            .variableColor.iterative.dimInactiveLayers,
                                            options: .repeating,
                                            isActive: context.isCurrentlyPlaying
                                        )
                                }
                            }
                        }
                        .transition(.opacity)
                        .zIndex(1)
                    }
                    .frame(width: 40.0, height: 40.0)
                    .clipShape(.rect(cornerRadius: 8.0))
                    .border(style: .quinaryFill, cornerRadius: 8.0)
                    
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text(song.title)
                            .lineLimit(1)
                            .font(.system(size: 12.0, weight: .medium))
                            .foregroundStyle(Color.primaryText)
                        
                        Text(song.artistName)
                            .lineLimit(1)
                            .font(.system(size: 12.0, weight: .regular))
                            .foregroundStyle(Color.secondaryText)
                    }
                }
                
                Spacer()
                
                HStack {
                    if let duration = song.duration?.minutesAndSeconds {
                        Text(duration)
                            .font(.system(size: 12.0, weight: .medium))
                            .foregroundStyle(Color.secondaryText)
                    }
                }
            }
            .animation(.easeIn(duration: 0.2), value: context.isHovered)
            
            Divider()
        }
    }
    
    func skeleton() -> some View {
        VStack {
            HStack {
                HStack(spacing: 12.0) {
                    Color.tertiaryFill
                        .frame(width: 40.0, height: 40.0)
                        .clipShape(.rect(cornerRadius: 8.0))
                    
                    VStack(alignment: .leading, spacing: 2.0) {
                        Color.tertiaryFill
                            .frame(width: 120.0, height: 12.0)
                            .clipShape(.rect(cornerRadius: 4.0))
                        
                        Color.tertiaryFill
                            .frame(width: 80.0, height: 12.0)
                            .clipShape(.rect(cornerRadius: 4.0))
                    }
                }
                
                Spacer()
                
                Color.tertiaryFill
                    .frame(width: 32.0, height: 12.0)
                    .clipShape(.rect(cornerRadius: 4.0))
            }
            
            Divider()
        }
    }
}

extension SongItemStyle where Self == PlainSongItemStyle {
    static var plain: PlainSongItemStyle {
        return .init()
    }
}
