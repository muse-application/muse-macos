//
//  SearchResultsSongsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchResultsSectionProvider {
    struct SongsSection: ProvidableSection {
        func section(with value: MusicItemCollection<Song>) -> some View {
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Songs")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 200.0), spacing: 24.0), count: 2), spacing: 8.0) {
                    ForEach(value) { song in
                        SongItem(song: song)
                    }
                }
            }
        }
        
        func skeleton() -> some View {
            VStack {
                
            }
        }
    }
}
