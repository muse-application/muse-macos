//
//  TrackCollectionDetailsView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 14.01.2024.
//

import SwiftUI

struct TrackCollectionDetailsView: View {
    private let trackCollectionItem: any MusicTrackCollection
    
    init(trackCollectionItem: any MusicTrackCollection) {
        self.trackCollectionItem = trackCollectionItem
    }
    
    var body: some View {
        HStack(spacing: 16.0) {
            self.info
            self.trackList
        }
    }
    
    // MARK: - Components
    
    private var info: some View {
        VStack(spacing: 16.0) {
            VStack(alignment: .leading, spacing: 8.0) {
                MusicArtworkImage(artwork: self.trackCollectionItem.artwork)
                    .frame(width: 256.0, height: 256.0)
                
                HStack {
                    Text(self.trackCollectionItem.title)
                        .font(.system(size: 14.0, weight: .bold))
                        .foregroundStyle(Color.primaryText)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("ellipsis.circle")
                            .font(.system(size: 14.0))
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
                
                if let authorName = self.trackCollectionItem.authorName {
                    Text(authorName)
                        .font(.system(size: 12.0, weight: .medium))
                        .foregroundStyle(Color.pinkAccent)
                }
                
                HStack(spacing: 2.0) {
                    if let genre = self.trackCollectionItem.genreNames.first {
                        Text(genre)
                    }
                    
                    if let releaseYear = self.trackCollectionItem.releaseDate?.format("YYYY") {
                        Text("•")
                        Text(releaseYear)
                    }
                }
                .font(.system(size: 12.0, weight: .bold))
                .foregroundColor(Color.secondaryText)
                
                if let description = self.trackCollectionItem.description {
                    Text(description)
                        .lineLimit(3)
                        .font(.system(size: 12.0, weight: .regular))
                        .foregroundStyle(Color.secondaryText)
                }
            }
        }
    }
    
    private var trackList: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            if !self.trackCollectionItem.songs.isEmpty {
                Text("Song List")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                ScrollView {
                    LazyVStack {
                        ForEach(Array(self.trackCollectionItem.songs.enumerated()), id: \.offset) { position, song in
                            SongItem(song: song, style: .grouped(at: position))
                        }
                    }
                }
            }
        }
    }
}
