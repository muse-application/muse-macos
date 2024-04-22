//
//  ArtistDetailsAlbumsSection.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

extension ArtistDetailsSectionProvider {
    struct AlbumsSection: ProvidableSection {
        struct Payload {
            let title: String
            let items: MusicItemCollection<Album>
        }
        
        func section(with value: Payload) -> some View {
            ScrollableSection(title: value.title, items: value.items) { album in
                NavigationLink(value: album) {
                    TrackCollectionItem(item: album, kind: .medium)
                }
                .buttonStyle(.plain)
            }
        }
        
        func skeleton() -> some View {
            ScrollableSection.Skeleton(quantity: 8) {
                TrackCollectionItem.Skeleton(kind: .medium)
            }
        }
    }
}
