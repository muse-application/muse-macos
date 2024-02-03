//
//  TrackCollectionDetailsInfoView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 30.01.2024.
//

import SwiftUI

extension TrackCollectionDetailsView {
    
    struct InfoView: View {
        private let item: MusicTrackCollection
        
        init(item: MusicTrackCollection) {
            self.item = item
        }
        
        var body: some View {
            VStack(spacing: 16.0) {
                VStack(alignment: .leading, spacing: 8.0) {
                    MusicArtworkImage(artwork: self.item.artwork)
                        .frame(width: 256.0, height: 256.0)
                        .clipShape(.rect(cornerRadius: 12.0))
                    
                    VStack(alignment: .leading, spacing: 2.0) {
                        HStack(alignment: .top) {
                            Text(self.item.title)
                                .font(.system(size: 16.0, weight: .bold))
                                .foregroundStyle(Color.primaryText)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis.circle")
                                    .font(.system(size: 18.0))
                            }
                            .buttonStyle(
                                .systemHoverable(
                                    style: .init(
                                        idleColors: (.pinkAccent, .pinkAccent.opacity(0.2)),
                                        hoveredColors: (.white, .pinkAccent)
                                    )
                                )
                            )
                        }
                        
                        if let authorName = self.item.authorName {
                            Text(authorName)
                                .font(.system(size: 14.0, weight: .medium))
                                .foregroundStyle(Color.pinkAccent)
                        }
                    }
                    
                    HStack(spacing: 2.0) {
                        if let genre = self.item.genreNames.first {
                            Text(genre.uppercased())
                        }
                        
                        if let releaseYear = self.item.releaseDate?.format("YYYY") {
                            Text("•")
                            Text(releaseYear)
                        }
                    }
                    .font(.system(size: 12.0, weight: .bold))
                    .foregroundColor(Color.secondaryText)
                    
                    if let description = self.item.description {
                        Text(description)
                            .lineLimit(3)
                            .font(.system(size: 14.0, weight: .regular))
                            .foregroundStyle(Color.secondaryText)
                    }
                }
            }
            .frame(width: 256.0)
        }
    }
    
}
