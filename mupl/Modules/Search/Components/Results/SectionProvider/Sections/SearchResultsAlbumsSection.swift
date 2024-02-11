//
//  SearchResultsAlbumsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchResultsSectionProvider {
    struct AlbumsSection: ProvidableSection {
        func section(with value: MusicItemCollection<Album>) -> some View {
            ScrollableSection(title: "Albums", items: value) { album in
                TrackCollectionItem(item: album, kind: .medium)
            }
        }
        
        func skeleton() -> some View {
            VStack {
                
            }
        }
    }
}
