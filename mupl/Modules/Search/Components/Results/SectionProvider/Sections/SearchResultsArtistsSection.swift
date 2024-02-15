//
//  SearchResultsArtistsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchResultsSectionProvider {
    struct ArtistsSection: ProvidableSection {
        struct Item: View {
            private let artist: Artist
            
            init(artist: Artist) {
                self.artist = artist
            }
            
            var body: some View {
                VStack(spacing: 12.0) {
                    MusicArtworkImage(artwork: self.artist.artwork)
                        .frame(width: 80.0, height: 80.0)
                        .clipShape(.rect(cornerRadius: 8.0))
                    
                    Text(self.artist.name)
                        .lineLimit(1)
                        .font(.system(size: 12.0, weight: .medium))
                        .foregroundStyle(Color.primaryText)
                }
                .padding(.all, 12.0)
                .frame(width: 100.0)
                .background(Color.quinaryFill)
                .clipShape(.rect(cornerRadius: 16.0))
            }
        }
        
        func section(with value: MusicItemCollection<Artist>) -> some View {
            ScrollableSection(title: "Artists", items: value) { artist in
                NavigationLink(value: artist) {
                    Item(artist: artist)
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
