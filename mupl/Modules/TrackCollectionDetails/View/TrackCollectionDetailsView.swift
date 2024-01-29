//
//  TrackCollectionDetailsView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 14.01.2024.
//

import SwiftUI
import MusicKit

struct TrackCollectionDetailsView: View {
    private let item: MusicTrackCollection
    
    @Environment(\.playbarHeight) private var playbarHeight
    
    @State private var songs: [Song] = .init()
    
    init(item: MusicTrackCollection) {
        self.item = item
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            self.info
            self.trackList
        }
        .padding([.top, .horizontal], 24.0)
        .padding(.bottom, self.playbarHeight)
        .task {
            self.songs = await self.item.songsProvider()
        }
    }
    
    // MARK: - Components
    
    private var info: some View {
        VStack(spacing: 16.0) {
            VStack(alignment: .leading, spacing: 8.0) {
                MusicArtworkImage(artwork: self.item.artwork)
                    .frame(width: 300.0, height: 300.0)
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
        .frame(width: 300.0)
    }
    
    private var trackList: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            if !self.songs.isEmpty {
                Text("Song List")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                ScrollView {
                    LazyVStack(spacing: 0.0) {
                        ForEach(Array(self.songs.enumerated()), id: \.offset) { position, song in
                            SongItem(song: song, style: .grouped(at: position + 1))
                        }
                    }
                    .padding(.bottom, 24.0)
                }
            }
        }
    }
}
