//
//  MusicCatalogCharts.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

extension MusicCatalog {
    struct Charts {
        func compilation(for genre: Genre? = nil) async -> MusicChartsCompilation {
            let charts = await self.charts(for: genre, kinds: [.mostPlayed, .dailyGlobalTop, .cityTop], types: [Song.self, Album.self, Playlist.self])
            let albumCharts = Dictionary(uniqueKeysWithValues: charts?.albumCharts.map { ($0.kind, $0) } ?? [])
            let playlistCharts = Dictionary(uniqueKeysWithValues: charts?.playlistCharts.map { ($0.kind, $0) } ?? [])
            
            return .init(
                topSongs: charts?.songCharts.first(where: { $0.kind == .mostPlayed }),
                mostPlayedAlbums: albumCharts[.mostPlayed],
                mostPlayedPlaylists: playlistCharts[.mostPlayed],
                dailyGlobalTopPlaylists: playlistCharts[.dailyGlobalTop],
                cityTopPlaylists: playlistCharts[.cityTop]
            )
        }
        
        func albumChart(for genre: Genre? = nil, _ kind: MusicCatalogChartKind) async -> MusicCatalogChart<Album>? {
            let charts = await self.charts(for: genre, kinds: [kind], types: [Album.self])
            return charts?.albumCharts.first(where: { $0.kind == kind })
        }
        
        func playlistChart(for genre: Genre? = nil, _ kind: MusicCatalogChartKind) async -> MusicCatalogChart<Playlist>? {
            let charts = await self.charts(for: genre, kinds: [kind], types: [Playlist.self])
            return charts?.playlistCharts.first(where: { $0.kind == kind })
        }
        
        func songChart(for genre: Genre? = nil, _ kind: MusicCatalogChartKind) async -> MusicCatalogChart<Song>? {
            let charts = await self.charts(for: genre, kinds: [kind], types: [Song.self])
            return charts?.songCharts.first(where: { $0.kind == kind })
        }
        
        private func charts(for genre: Genre?, kinds: [MusicCatalogChartKind], types: [MusicCatalogChartRequestable.Type]) async -> MusicCatalogChartsResponse? {
            let request = MusicCatalogChartsRequest(genre: genre, kinds: kinds, types: types)
            return try? await request.response()
        }
    }
}
