//
//  SearchOverviewGenresSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchOverviewSectionProvider {
    struct GenresSection: ProvidableSection {
        struct Item: View {
            private let genre: Genre
            
            @State private var isHovered: Bool = false
            
            init(genre: Genre) {
                self.genre = genre
            }
            
            var body: some View {
                VStack {
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 14.0))
                        .foregroundStyle(Color.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Spacer()
                    
                    Text(self.genre.name)
                        .font(.system(size: 16.0, weight: .bold))
                        .foregroundStyle(Color.pinkAccent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 12.0)
                .padding(.horizontal, 16.0)
                .frame(height: 80.0)
                .background(Color.quinaryFill)
                .clipShape(.rect(cornerRadius: 8.0))
                .opacity(self.isHovered ? 0.6 : 1.0)
                .animation(.easeIn(duration: 0.2), value: self.isHovered)
                .onHover { hovered in
                    self.isHovered = hovered
                }
            }
            
            struct Skeleton: View {
                var body: some View {
                    Color.quinaryFill
                        .frame(height: 80.0)
                        .frame(maxWidth: .infinity)
                        .clipShape(.rect(cornerRadius: 8.0))
                }
            }
        }
        
        func section(with value: [Genre]) -> some View {
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Browse Genres")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 200.0)), count: 4)) {
                    ForEach(value) { genre in
                        NavigationLink(value: genre) {
                            Item(genre: genre)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        
        func skeleton() -> some View {
            VStack {
                LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 200.0)), count: 4)) {
                    ForEach(0 ..< 8, id: \.self) { _ in
                        Item.Skeleton()
                    }
                }
            }
        }
    }
}
