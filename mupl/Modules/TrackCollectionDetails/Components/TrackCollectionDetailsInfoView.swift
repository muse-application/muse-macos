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
                VStack(alignment: .leading, spacing: 12.0) {
                    MusicArtworkImage(artwork: self.item.artwork)
                        .frame(width: 256.0, height: 256.0)
                        .clipShape(.rect(cornerRadius: 12.0))
                        .glow(
                            using: .init(
                                color: Color(cgColor: self.item.artwork?.backgroundColor ?? .black),
                                radius: 16.0,
                                duration: 8.0
                            )
                        )
                    
                    self.info
                }
                
                self.buttons
            }
            .frame(width: 256.0)
        }
        
        // MARK: - Components
        
        private var info: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4.0) {
                        Text(self.item.title)
                            .font(.system(size: 18.0, weight: .bold))
                            .foregroundStyle(Color.primaryText)
                        
                        if let authorName = self.item.authorName {
                            Text(authorName)
                                .font(.system(size: 16.0, weight: .medium))
                                .foregroundStyle(Color.pinkAccent)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.system(size: 24.0))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color.pinkAccent)
                    }
                    .buttonStyle(.plain)
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
        
        private var buttons: some View {
            HStack(spacing: 4.0) {
                Button {
                    
                } label: {
                    HStack(spacing: 4.0) {
                        Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.app(.primary))

                Button {
                    
                } label: {
                    HStack(spacing: 4.0) {
                        Image(systemName: "shuffle")
                        Text("Shuffle")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.app(.secondary))
            }
        }
    }
    
}
