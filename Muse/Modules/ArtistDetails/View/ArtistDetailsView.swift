//
//  ArtistDetailsView.swift
//  Muse
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
        VStack(alignment: .leading, spacing: 16.0) {
            InfoView(artist: self.artist.value ?? self.item)
                .padding([.top, .horizontal], 24.0)
            
            VStack(spacing: 0.0) {
                Divider()
                    .padding(.horizontal, 24.0)
                
                switch self.artist.status {
                case .idle:
                    Color.clear
                case .loading:
                    self.skeleton
                case .loaded(let artist):
                    self.content(artist)
                case .error:
                    Color.clear
                }
            }
            .transition(.opacity)
        }
        .animation(.easeIn, value: self.artist.status)
        .onAppear {
            self.artist.load {
                var artist = self.item
                
                if artist.id.rawValue.isEmpty {
                    // It is possible that ID of the artist
                    // could be empty (Library). This leads to
                    // errors when trying to fetch artist info.
                    // Therefore we should handle this case by
                    // trying to search by name of an artist first.
                    artist = try await Artist.named(self.item.name)
                }
                
                return try await artist.with(
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
    
    private var skeleton: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16.0) {
                self.sectionProvider.skeleton(for: \.latestRelease)
                self.sectionProvider.skeleton(for: \.topSongs)
                self.sectionProvider.skeleton(for: \.featuredAlbums)
                self.sectionProvider.skeleton(for: \.albums)
            }
            .padding(.all, 24.0)
        }
        .scrollDisabled(true)
    }
    
    private func content(_ artist: Artist) -> some View {
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
                    self.sectionProvider.section(for: \.albums, value: .init(title: "Singles & EPs", items: singles))
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
