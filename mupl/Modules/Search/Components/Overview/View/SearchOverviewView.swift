//
//  SearchOverviewView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchView {
    struct OverviewView: View {
        private let sectionProvider: SearchOverviewSectionProvider = .init()
        
        @EnvironmentObject private var musicCatalog: MusicCatalog
        
        @State private var genre: LoadableValue<[Genre]> = .init()
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16.0) {
                    switch self.genre.status {
                    case .idle, .loading:
                        self.sectionProvider.skeleton(for: \.genres)
                    case .loaded(let genres):
                        self.sectionProvider.section(for: \.genres, value: genres)
                    case .error:
                        Color.clear
                    }
                }
                .padding(.all, 24.0)
            }
            .onAppear {
                self.genre.load {
                    await self.musicCatalog.genres.trending
                }
            }
        }
    }
}
