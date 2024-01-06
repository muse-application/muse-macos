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
        var compilation: MusicChartsCompilation {
            get async {
                let charts = await self.charts(for: [.mostPlayed, .dailyGlobalTop, .cityTop], types: [Song.self, Playlist.self])
                let playlistCharts = Dictionary(uniqueKeysWithValues: charts?.playlistCharts.map { ($0.kind, $0) } ?? [])
                
                return .init(
                    topSongs: charts?.songCharts.first(where: { $0.kind == .mostPlayed }),
                    mostPlayedPlaylists: playlistCharts[.mostPlayed],
                    dailyGlobalTopPlaylists: playlistCharts[.dailyGlobalTop],
                    cityTopPlaylists: playlistCharts[.cityTop]
                )
            }
        }
        
        func playlistChart(_ kind: MusicCatalogChartKind) async -> MusicCatalogChart<Playlist>? {
            let charts = await self.charts(for: [kind], types: [Playlist.self])
            return charts?.playlistCharts.first(where: { $0.kind == kind })
        }
        
        func songChart(_ kind: MusicCatalogChartKind) async -> MusicCatalogChart<Song>? {
            let charts = await self.charts(for: [kind], types: [Song.self])
            return charts?.songCharts.first(where: { $0.kind == kind })
        }
        
        private func charts(for kinds: [MusicCatalogChartKind], types: [MusicCatalogChartRequestable.Type]) async -> MusicCatalogChartsResponse? {
            let request = MusicCatalogChartsRequest(kinds: kinds, types: types)
            return try? await request.response()
        }
    }
}
