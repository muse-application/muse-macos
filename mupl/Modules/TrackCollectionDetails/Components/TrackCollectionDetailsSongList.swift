//
//  TrackCollectionDetailsSongList.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 30.01.2024.
//

import SwiftUI
import MusicKit

extension TrackCollectionDetailsView {
    
    struct SongList: View {
        struct Content: Hashable {
            let songs: [Song]
            let duration: TimeInterval
        }
        
        private let songsProvider: @Sendable () async -> [Song]
        
        @State private var songs: LoadableValue<Content> = .init()
        
        init(songsProvider: @Sendable @escaping () async -> [Song]) {
            self.songsProvider = songsProvider
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16.0) {
                Text("Song List")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                ZStack {
                    if self.songs.value == nil {
                        Color.quinaryFill
                            .clipShape(.rect(cornerRadius: 8.0))
                            .padding(.bottom, 24.0)
                    }
                    
                    switch self.songs.status {
                    case .idle:
                        Color.clear
                    case .loading:
                        ProgressView()
                    case .loaded(let content):
                        self.list(content: content)
                    case .error(let error):
                        self.error(error)
                    }
                }
                .transition(.opacity)
                .animation(.easeIn, value: self.songs.status)
            }
            .onAppear {
                self.songs.load {
                    let songs = await self.songsProvider()
                    let duration = songs.reduce(into: 0.0, { $0 += $1.duration ?? 0.0 })
                    return .init(songs: songs, duration: duration)
                }
            }
        }
        
        // MARK: - Components
        
        @ViewBuilder
        private func list(content: Content) -> some View {
            if !content.songs.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16.0) {
                        LazyVStack(spacing: 0.0) {
                            ForEach(Array(content.songs.enumerated()), id: \.offset) { position, song in
                                SongItem(song: song, style: .grouped(at: position + 1))
                            }
                        }
                        
                        Text("\(content.songs.count) songs, \(content.duration.minutes) minutes")
                            .font(.system(size: 12.0, weight: .medium))
                            .foregroundStyle(Color.secondaryText)
                    }
                    .padding(.bottom, 24.0)
                }
            }
        }
        
        private func error(_ error: AppError) -> some View {
            VStack(spacing: 4.0) {
                Text(error.title)
                    .font(.system(size: 14.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                Text(error.description)
                    .font(.system(size: 14.0, weight: .regular))
                    .foregroundStyle(Color.secondaryText)
            }
        }
    }
    
}
