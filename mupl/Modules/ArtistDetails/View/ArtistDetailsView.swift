//
//  ArtistDetailsView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

struct ArtistDetailsView: View {
    private let item: Artist
    private let sectionProvider: ArtistDetailsSectionProvider = .init()
    
    @State private var artist: LoadableValue<Artist> = .init()
    
    init(artist: Artist) {
        self.item = artist
    }
    
    var body: some View {
        ZStack {
            switch self.artist.status {
            case .idle:
                Color.clear
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let artist):
                self.content(artist)
            case .error:
                Color.clear
            }
        }
        .transition(.opacity)
        .animation(.easeIn, value: self.artist.status)
        .onAppear {
            self.artist.load {
                try await self.item.with(
                    .latestRelease,
                    .topSongs,
                    .featuredAlbums,
                    .albums,
                    .singles,
                    .playlists,
                    .appearsOnAlbums
                )
            }
        }
    }
    
    // MARK: - Components
    
    private func content(_ artist: Artist) -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            InfoView(artist: artist)
                .padding([.top, .horizontal], 24.0)
            
            VStack(spacing: 0.0) {
                Divider()
                    .padding(.horizontal, 24.0)
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16.0) {
                        if let latestRelease = artist.latestRelease {
                            self.sectionProvider.section(for: \.latestRelease, value: latestRelease)
                        }
                        
                        if let topSongs = artist.topSongs, !topSongs.isEmpty {
                            self.sectionProvider.section(for: \.topSongs, value: topSongs)
                        }
                        
                        if let featuredAlbums = artist.featuredAlbums, !featuredAlbums.isEmpty {
                            self.sectionProvider.section(for: \.featuredAlbums, value: featuredAlbums)
                        }
                        
                        if let albums = artist.albums, !albums.isEmpty {
                            self.sectionProvider.section(for: \.albums, value: .init(title: "Albums", items: albums))
                        }
                        
                        if let singles = artist.singles, !singles.isEmpty {
                            self.sectionProvider.section(for: \.albums, value: .init(title: "Singles", items: singles))
                        }
                        
                        if let playlists = artist.playlists, !playlists.isEmpty {
                            self.sectionProvider.section(for: \.playlists, value: .init(title: "Playlists", items: playlists))
                        }
                        
                        if let appearsOnAlbums = artist.appearsOnAlbums, !appearsOnAlbums.isEmpty {
                            self.sectionProvider.section(for: \.albums, value: .init(title: "Appears On", items: appearsOnAlbums))
                        }
                    }
                    .padding(.all, 24.0)
                }
            }
        }
    }
}
