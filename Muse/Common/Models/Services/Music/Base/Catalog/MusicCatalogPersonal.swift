//
//  MusicCatalogPersonal.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

extension MusicCatalog {
    struct Personal {
        enum LibraryFilterType {
            case albums
            case playlists
            case songs
            
            var type: any MusicLibraryRequestable.Type {
                switch self {
                case .albums:
                    return Album.self
                case .playlists:
                    return Playlist.self
                case .songs:
                    return Song.self
                }
            }
        }
        
        var recommendations: [MusicPersonalRecommendationItem] {
            get async throws {
                let request = MusicPersonalRecommendationsRequest()
                let response = try await request.response()
                
                return response.recommendations
                    .compactMap { recommendation in
                        guard !recommendation.items.isEmpty else { return nil }
                        
                        return .init(
                            type: .init(id: recommendation.id.rawValue),
                            title: recommendation.title ?? "Recommended for You",
                            items: recommendation.items
                        )
                    }
            }
        }
        
        func library<MusicItemType: MusicLibraryRequestable>(of filterType: MusicItemType.Type) async -> MusicItemCollection<MusicItemType> {
            let request = MusicLibraryRequest<MusicItemType>()
            let response = try? await request.response()
            
            return response?.items ?? .init()
        }
    }
}
