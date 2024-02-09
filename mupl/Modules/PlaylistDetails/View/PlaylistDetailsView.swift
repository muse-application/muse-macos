//
//  PlaylistDetailsView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 09.02.2024.
//

import SwiftUI
import MusicKit

struct PlaylistDetailsView: View {
    private let item: Playlist
    
    @State private var playlist: LoadableValue<Playlist> = .init()
    
    init(playlist: Playlist) {
        self.item = playlist
    }
    
    var body: some View {
        ZStack {
            switch self.playlist.status {
            case .idle:
                Color.clear
            case .loading:
                ProgressView()
            case .loaded(let playlist):
                self.content(playlist: playlist)
            case .error(let error):
                self.error(error)
            }
        }
        .transition(.opacity)
        .animation(.easeIn, value: self.playlist.status)
        .onAppear {
            self.playlist.load {
                try await item.with(.tracks)
            }
        }
    }
    
    // MARK: - Components
    
    private func content(playlist: Playlist) -> some View {
        ScrollView {
            VStack(spacing: 32.0) {
                InfoView(playlist: playlist)
                TrackList(tracks: playlist.tracks)
            }
            .padding(.all, 24.0)
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
