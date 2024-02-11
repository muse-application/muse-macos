//
//  SearchResultsView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchView {
    struct ResultsView: View {
        private let results: MusicSearchResults
        private let sectionProvider: SearchResultsSectionProvider = .init()
        
        init(results: MusicSearchResults) {
            self.results = results
        }
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16.0) {
                    self.sectionProvider.section(for: \.topResults, value: self.results.topResults)
                    
                    if !self.results.artists.isEmpty {
                        self.sectionProvider.section(for: \.artists, value: self.results.artists)
                    }
                    
                    if !self.results.albums.isEmpty {
                        self.sectionProvider.section(for: \.albums, value: self.results.albums)
                    }
                    
                    if !self.results.playlists.isEmpty {
                        self.sectionProvider.section(for: \.playlists, value: self.results.playlists)
                    }
                    
                    if !self.results.songs.isEmpty {
                        self.sectionProvider.section(for: \.songs, value: self.results.songs)
                    }
                }
                .padding(.all, 24.0)
            }
        }
    }
}
