//
//  PlaybarSongControls.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

extension Playbar {
    struct SongControls: View {
        @EnvironmentObject private var musicPlayer: MusicPlayer
        
        @State private var isSliderHovered: Bool = false
        @State private var playbackTimePercentage: CGFloat = 0.0
        
        var body: some View {
            VStack(spacing: 4.0) {
                self.controls
                self.slider
            }
            .onChange(of: self.musicPlayer.playbackTime) { _, value in
                guard let duration = self.musicPlayer.currentSong?.duration else { return }
                self.playbackTimePercentage = value / duration
            }
        }
        
        // MARK: - Components
        
        private var controls: some View {
            HStack(spacing: 8.0) {
                Image(systemName: "shuffle")
                    .font(.system(size: 10.0, weight: .medium))
                    .foregroundStyle(self.musicPlayer.shuffleMode == .songs ? Color.pinkAccent : Color.secondaryText)
                    .tappable {
                        self.musicPlayer.shuffleMode.toggle()
                    }
                
                Group {
                    Image(systemName: "backward.fill")
                        .foregroundStyle(Color.secondaryText)
                        .tappable {
                            self.musicPlayer.skip(.backward)
                        }
                    
                    Group {
                        if self.musicPlayer.playbackState == .loading {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color.secondaryText)
                                .symbolEffect(.variableColor.iterative.dimInactiveLayers, options: .repeating)
                        } else {
                            Image(systemName: self.musicPlayer.playbackState == .playing ? "pause.fill" : "play.fill")
                                .foregroundStyle(Color.secondaryText)
                                .tappable {
                                    Task {
                                        if self.musicPlayer.playbackState == .playing {
                                            self.musicPlayer.pause()
                                        } else {
                                            await self.musicPlayer.play()
                                        }
                                    }
                                }
                        }
                    }
                    .frame(width: 20.0)
                    
                    Image(systemName: "forward.fill")
                        .foregroundStyle(Color.secondaryText)
                        .tappable {
                            self.musicPlayer.skip(.forward)
                        }
                }
                .font(.system(size: 14.0, weight: .medium))
                
                Image(systemName: self.musicPlayer.repeatMode == .one ? "repeat.1" : "repeat")
                    .font(.system(size: 10.0, weight: .medium))
                    .foregroundStyle(self.musicPlayer.repeatMode != .none ? Color.pinkAccent : Color.secondaryText)
                    .tappable {
                        self.musicPlayer.repeatMode.next()
                    }
            }
            .frame(height: 24.0)
        }
        
        private var slider: some View {
            HStack(spacing: 8.0) {
                Group {
                    if let duration = self.musicPlayer.currentSong?.duration, self.isSliderHovered {
                        Text((self.playbackTimePercentage * duration).minutesAndSeconds)
                            .font(.system(size: 10.0))
                            .foregroundStyle(Color.secondaryText)
                    } else {
                        Color.clear
                    }
                }
                .frame(width: 24.0, height: 12.0)
                
                Slider(width: .flexible(min: 320.0, ideal: 320.0, max: 500.0), percentage: self.$playbackTimePercentage)
                    .onDrag {
                        self.musicPlayer.pause()
                    }
                    .onChange { requestedPercentage in
                        guard let duration = self.musicPlayer.currentSong?.duration else { return }
                        
                        self.playbackTimePercentage = requestedPercentage
                        
                        self.musicPlayer.seek(to: requestedPercentage * duration)
                        
                        Task {
                            await self.musicPlayer.play()
                        }
                    }
                    .onHover { hovered in
                        self.isSliderHovered = hovered
                    }
                
                Group {
                    if let duration = self.musicPlayer.currentSong?.duration, self.isSliderHovered {
                        Text(duration.minutesAndSeconds)
                            .font(.system(size: 10.0))
                            .foregroundStyle(Color.secondaryText)
                    } else {
                        Color.clear
                    }
                }
                .frame(width: 24.0, height: 12.0)
            }
            .frame(height: 12.0)
            .animation(.easeIn(duration: 0.2), value: self.isSliderHovered)
        }
    }
}
