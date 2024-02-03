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
        private let songsProvider: @Sendable () async -> [Song]
        
        @State private var songs: LoadableValue<[Song]> = .init()
        
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
                    case .loaded(let songs):
                        self.list(songs: songs)
                    case .error(let error):
                        self.error(error)
                    }
                }
                .transition(.opacity)
                .animation(.easeIn, value: self.songs.status)
            }
            .onAppear {
                self.songs.load {
                    await self.songsProvider()
                }
            }
        }
        
        // MARK: - Components
        
        @ViewBuilder
        private func list(songs: [Song]) -> some View {
            if !songs.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 0.0) {
                        ForEach(Array(songs.enumerated()), id: \.offset) { position, song in
                            SongItem(song: song, style: .grouped(at: position + 1))
                        }
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
