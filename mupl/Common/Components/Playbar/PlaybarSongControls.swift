//
//  PlaybarSongControls.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct PlaybarSongControls: View {
    @EnvironmentObject private var musicPlayer: MusicPlayer
    
    @State private var playbackTimePercentage: CGFloat = 0.0
    
    var body: some View {
        VStack(spacing: 8.0) {
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
                    
                    Image(systemName: self.musicPlayer.playbackStatus == .playing ? "pause.fill" : "play.fill")
                        .foregroundStyle(Color.secondaryText)
                        .tappable {
                            Task {
                                if self.musicPlayer.playbackStatus == .playing {
                                    self.musicPlayer.pause()
                                } else {
                                    await self.musicPlayer.play()
                                }
                            }
                        }
                    
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
        }
        .onChange(of: self.musicPlayer.playbackTime) { _, value in
            guard let duration = self.musicPlayer.currentSong?.duration else { return }
            self.playbackTimePercentage = value / duration
        }
    }
}
