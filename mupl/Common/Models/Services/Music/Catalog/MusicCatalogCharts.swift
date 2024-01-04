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
        var mostPlayed: MusicCatalogChart<Playlist>? {
            get async {
                return await self.requestChartPlaylist(of: .mostPlayed)
            }
        }
        
        var dailyGlobalTop: MusicCatalogChart<Playlist>? {
            get async {
                return await self.requestChartPlaylist(of: .dailyGlobalTop)
            }
        }
        
        var cityTop: MusicCatalogChart<Playlist>? {
            get async {
                return await self.requestChartPlaylist(of: .cityTop)
            }
        }
        
        private func requestChartPlaylist(of kind: MusicCatalogChartKind) async -> MusicCatalogChart<Playlist>? {
            let request = MusicCatalogChartsRequest(kinds: [kind], types: [Playlist.self])
            let response = try? await request.response()
            
            return response?.playlistCharts.first(where: { $0.kind == kind })
        }
    }
}
