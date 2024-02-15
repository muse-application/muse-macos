//
//  ChartSongsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

extension ChartSectionProvider {
    struct SongsSection: ProvidableSection {
        let columns: [GridItem] = [
            .init(.flexible(minimum: 300.0, maximum: 500.0), spacing: .s6),
            .init(.flexible(minimum: 300.0, maximum: 500.0), spacing: .s6)
        ]
        
        func section(with value: MusicCatalogChart<Song>) -> some View {
            VStack(alignment: .leading, spacing: .s6) {
                Text(value.title)
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                LazyVGrid(columns: self.columns, spacing: .s2) {
                    ForEach(value.items) { item in
                        SongItem(song: item)
                    }
                }
            }
        }
        
        func skeleton() -> some View {
            VStack(alignment: .leading, spacing: .s6) {
                Color.tertiaryFill
                    .frame(width: 150.0, height: 16.0)
                    .clipShape(.rect(cornerRadius: 4.0))
                
                LazyVGrid(columns: self.columns, spacing: .s2) {
                    ForEach(0 ..< 8, id: \.self) { _ in
                        SongItem.Skeleton()
                    }
                }
            }
        }
    }
}
