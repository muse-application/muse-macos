//
//  SearchResultsPlaylistsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 11.02.2024.
//

import SwiftUI
import MusicKit

extension SearchResultsSectionProvider {
    struct PlaylistsSection: ProvidableSection {
        func section(with value: MusicItemCollection<Playlist>) -> some View {
            ScrollableSection(title: "Playlists", items: value) { playlist in
                NavigationLink(value: playlist) {
                    TrackCollectionItem(item: playlist, kind: .medium)
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
