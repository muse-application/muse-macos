//
//  SearchView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI
import MusicKit

struct SearchView: View {
    @EnvironmentObject private var musicCatalog: MusicCatalog
    
    @State private var searchTerm: String = ""
    @State private var results: LoadableValue<MusicSearchResults> = .init()
    
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0.0) {
                TextField("Songs, artists, lyrics...", text: self.$searchTerm)
                    .textFieldStyle(.app(icon: "magnifyingglass"))
                    .focused(self.$isSearchFieldFocused)
                    .font(.system(size: 14.0, weight: .regular))
                    .frame(width: 256.0)
                    .padding([.top, .leading], 24.0)
                    .onChange(of: self.searchTerm, debounce: .seconds(1)) { searchTerm in
                        if searchTerm.isEmpty {
                            self.results.reset()
                        }
                    }
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
            .navigationDestination(for: Album.self) { album in
                AlbumDetailsView(album: album)
            }
            .navigationDestination(for: Playlist.self) { playlist in
                PlaylistDetailsView(playlist: playlist)
            }
        }
    }
}

