//
//  ArtistDetailsFeaturedAlbumsSection.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

extension ArtistDetailsSectionProvider {
    struct FeaturedAlbumsSection: ProvidableSection {
        func section(with value: MusicItemCollection<Album>) -> some View {
            ScrollableSection(title: "Featured Albums", items: value) { album in
                NavigationLink(value: album) {
                    TrackCollectionItem(item: album, kind: .large)
                }
                .buttonStyle(.plain)
            }
        }
        
        func skeleton() -> some View {
            ScrollableSection.Skeleton(quantity: 8) {
                TrackCollectionItem.Skeleton(kind: .large)
            }
        }
    }
}
