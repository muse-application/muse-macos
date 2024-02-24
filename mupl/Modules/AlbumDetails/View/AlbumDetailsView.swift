//
//  AlbumDetailsView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 14.01.2024.
//

import SwiftUI
import MusicKit

struct AlbumDetailsView: View {
    private let item: Album
    
    @State private var album: LoadableValue<Album> = .init()
    
    init(album: Album) {
        self.item = album
    }
    
    var body: some View {
        ZStack {
            switch self.album.status {
            case .idle:
                Color.clear
            case .loading:
                ProgressView()
            case .loaded(let album):
                self.content(album: album)
            case .error(let error):
                self.error(error)
            }
        }
        .transition(.opacity)
        .animation(.easeIn, value: self.album.status)
        .onAppear {
            self.album.load {
                try await self.item.with(.tracks, .artists)
            }
        }
    }
    
    // MARK: - Components
    
    private func content(album: Album) -> some View {
        ScrollView {
            HStack(alignment: .top, spacing: 16.0) {
                InfoView(album: album)
                TrackList(tracks: album.tracks)
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
