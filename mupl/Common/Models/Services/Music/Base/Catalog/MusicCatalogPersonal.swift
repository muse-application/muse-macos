//
//  MusicCatalogPersonal.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

extension MusicCatalog {
    struct Personal {
        var recentlyPlayed: [MusicTrackCollection] {
            get async {
                let request = MusicRecentlyPlayedContainerRequest()
                let response = try? await request.response()
                
                if let items = response?.items {
                    return items
                        .compactMap { item in
                            switch item {
                            case .album(let album):
                                return .init(album: album)
                            case .playlist(let playlist):
                                return .init(playlist: playlist)
                            case .station(let station):
                                return .init(station: station)
                            @unknown default:
                                return nil
                            }
                        }
                }
                
                return []
            }
        }
        
        var recommendations: [MusicPersonalRecommendationItem] {
            get async {
                let request = MusicPersonalRecommendationsRequest()
                let response = try? await request.response()
                
                if let recommendations = response?.recommendations {
                    return recommendations
                        .compactMap { recommendation in
                            // Mapping resulting array to more convenient type
                            // with common type for music items (albums, playlist, stations).
                            var items: [MusicTrackCollection] = []
                            
                            if recommendation.types.count > 1 {
                                items = recommendation.items
                                    .compactMap { item in
                                        switch item {
                                        case .album(let album):
                                            return .init(album: album)
                                        case .playlist(let playlist):
                                            return .init(playlist: playlist)
                                        case .station(let station):
                                            return .init(station: station)
                                        @unknown default:
                                            return nil
                                        }
                                    }
                            } else {
                                if recommendation.types.first is Album.Type {
                                    items = recommendation.albums.map { .init(album: $0) }
                                }
                                
                                if recommendation.types.first is Playlist.Type {
                                    items = recommendation.playlists.map { .init(playlist: $0) }
                                }
                                
                                if recommendation.types.first is Station.Type {
                                    items = recommendation.stations.map { .init(station: $0) }
                                }
                            }
                            
                            guard !items.isEmpty else { return nil }
                            
                            return .init(
                                type: .init(id: recommendation.id.rawValue),
                                title: recommendation.title ?? "Recommended for You",
                                items: items
                            )
                        }
                }
                
                return []
            }
        }
    }
}
