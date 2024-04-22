//
//  SearchView.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI
import MusicKit

struct SearchView: View {
    @EnvironmentObject private var musicCatalog: MusicCatalog
    @EnvironmentObject private var router: Router
    
    @State private var searchTerm: String = ""
    @State private var results: LoadableValue<MusicSearchResults> = .init()
    
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        NavigationStack(path: self.router.bindablePath(for: .search)) {
            VStack(alignment: .leading, spacing: 8.0) {
                HStack(spacing: 8.0) {
                    TextField("Songs, artists, lyrics...", text: self.$searchTerm)
                        .textFieldStyle(.app(icon: "magnifyingglass"))
                        .focused(self.$isSearchFieldFocused)
                        .font(.system(size: 14.0, weight: .regular))
                        .frame(width: 256.0)
                        .onSubmit {
                            self.isSearchFieldFocused = false
                            
                            guard !self.searchTerm.isEmpty else { return self.results.reset() }
                            
                            self.results.load {
                                try await self.musicCatalog.search.request(
                                    term: self.searchTerm,
                                    types: [
                                        Artist.self,
                                        Album.self,
                                        Playlist.self,
                                        Song.self,
                                    ]
                                )
                            }
                        }
                    
                    if self.results.status.isLoaded {
                        Button {
                            self.searchTerm = ""
                            self.results.reset()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 16.0, weight: .semibold))
                                .foregroundStyle(Color.pinkAccent)
                                .frame(width: 44.0, height: 44.0)
                                .background(Color.quinaryFill)
                                .clipShape(.rect(cornerRadius: 8.0))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding([.top, .leading], 24.0)
                
                ZStack {
                    switch self.results.status {
                    case .idle:
                        OverviewView()
                    case .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .loaded(let results):
                        ResultsView(results: results)
                    case .error:
                        Color.clear
                    }
                }
                .transition(.opacity)
                .animation(.easeIn, value: self.results.status)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.isSearchFieldFocused = false
            }
            .navigationDestination(for: Artist.self) { artist in
                ArtistDetailsView(artist: artist)
            }
            .navigationDestination(for: Genre.self) { genre in
                ChartView(genre: genre)
            }
            .navigationDestination(for: Album.self) { album in
                AlbumDetailsView(album: album)
            }
            .navigationDestination(for: Playlist.self) { playlist in
                PlaylistDetailsView(playlist: playlist)
            }
        }
    }
}

