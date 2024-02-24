//
//  PlaylistDetailsTrackList.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 09.02.2024.
//

import SwiftUI
import MusicKit

extension PlaylistDetailsView {
    
    struct TrackList: View {
        private let songs: [Song]
        private let duration: TimeInterval
        
        init(tracks: MusicItemCollection<Track>?) {
            if let tracks = tracks {
                self.songs = tracks.compactMap { track in
                    guard case .song(let song) = track else { return nil }
                    return song
                }
                self.duration = self.songs.reduce(into: 0.0) { $0 += $1.duration ?? 0.0 }
            } else {
                self.songs = []
                self.duration = 0.0
            }
        }
        
        var body: some View {
            LazyVStack(alignment: .leading, spacing: 8.0) {
                ForEach(self.songs) { song in
                    SongItem(song: song, style: .plain)
                }
                
                Text("\(self.songs.count) songs, \(self.duration.minutes) minutes")
                    .font(.system(size: 12.0, weight: .medium))
                    .foregroundStyle(Color.secondaryText)
            }
        }
    }
    
}
