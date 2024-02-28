//
//  AlbumDetailsTrackList.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 30.01.2024.
//

import SwiftUI
import MusicKit

extension AlbumDetailsView {
    
    struct TrackList: View {
        private struct SongCollection {
            let items: [Song]
            let duration: TimeInterval
            
            init(songs: [Song]) {
                self.items = songs
                self.duration = songs.reduce(into: 0.0, { $0 += $1.duration ?? 0.0 })
            }
        }
        
        private let songs: SongCollection
        private let musicVideos: [MusicVideo]
        
        init(tracks: MusicItemCollection<Track>?) {
            if let tracks = tracks {
                self.songs = .init(
                    songs: tracks.compactMap { track in
                        guard case .song(let song) = track else { return nil }
                        return song
                    }
                )
                
                self.musicVideos = tracks.compactMap { track in
                    guard case .musicVideo(let musicVideo) = track else { return nil}
                    return musicVideo
                }
            } else {
                self.songs = .init(songs: [])
                self.musicVideos = []
            }
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                self.songList
            }
        }
        
        // MARK: - Components
        
        private var songList: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                Text("Song List")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                if self.songs.items.isEmpty {
                    ZStack {
                        Color.quinaryFill
                            .clipShape(.rect(cornerRadius: 8.0))
                        
                        VStack(spacing: 4.0) {
                            Text("No songs")
                                .font(.system(size: 14.0, weight: .bold))
                                .foregroundStyle(Color.primaryText)
                            
                            Text("No songs")
                                .font(.system(size: 14.0, weight: .regular))
                                .foregroundStyle(Color.secondaryText)
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 16.0) {
                        LazyVStack(spacing: 0.0) {
                            ForEach(Array(self.songs.items.enumerated()), id: \.offset) { position, song in
                                SongItem(song: song, style: .grouped(at: position + 1))
                            }
                        }
                        
                        Text("\(self.songs.items.count) songs, \(self.songs.duration.minutes) minutes")
                            .font(.system(size: 12.0, weight: .medium))
                            .foregroundStyle(Color.secondaryText)
                    }
                    .padding(.bottom, 24.0)
                }
            }
        }
    }
    
}
