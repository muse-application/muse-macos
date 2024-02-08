//
//  HomeChartsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import SwiftUI
import MusicKit

extension HomeSectionProvider {
    struct ChartsSection: ProvidableSection {
        func section(with value: MusicChartsCompilation) -> some View {
            VStack(alignment: .leading, spacing: .s8) {
                if let topSongs = value.topSongs {
                    TopSongsChartSection().section(with: topSongs)
                }
                
                if let mostPlayedPlaylists = value.mostPlayedPlaylists {
                    PlaylistChartSection().section(with: mostPlayedPlaylists)
                }
                
                if let dailyGlobalTopPlaylists = value.dailyGlobalTopPlaylists {
                    PlaylistChartSection().section(with: dailyGlobalTopPlaylists)
                }
                
                if let cityTopPlaylists = value.cityTopPlaylists {
                    PlaylistChartSection().section(with: cityTopPlaylists)
                }
            }
        }
        
        func skeleton() -> some View {
            VStack(alignment: .leading, spacing: .s8) {
                TopSongsChartSection().skeleton()
                PlaylistChartSection().skeleton()
                PlaylistChartSection().skeleton()
                PlaylistChartSection().skeleton()
            }
        }
    }
}


// MARK: - Playlist

extension HomeSectionProvider.ChartsSection {
    struct PlaylistChartSection: ProvidableSection {
        func section(with value: MusicCatalogChart<Playlist>) -> some View {
            ScrollableSection(title: value.title, items: value.items) { item in
                NavigationLink(value: item) {
                    TrackCollectionItem(item: .init(playlist: item), kind: .medium)
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


// MARK: - Top Songs

extension HomeSectionProvider.ChartsSection {
    struct TopSongsChartSection: ProvidableSection {
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
            .padding(.all, 16.0)
            .border(style: .quinaryFill, width: 2.0, cornerRadius: 12.0)
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
