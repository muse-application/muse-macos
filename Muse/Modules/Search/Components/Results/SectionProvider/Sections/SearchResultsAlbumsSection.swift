//
//  SearchResultsAlbumsSection.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchResultsSectionProvider {
    struct AlbumsSection: ProvidableSection {
        func section(with value: MusicItemCollection<Album>) -> some View {
            ScrollableSection(title: "Albums", items: value) { album in
                NavigationLink(value: album) {
                    TrackCollectionItem(item: album, kind: .medium)
                }
                .buttonStyle(.plain)
            }
        }
        
        func skeleton() -> some View {
            VStack {
                
            }
        }
    }
}
