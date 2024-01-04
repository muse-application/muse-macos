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
        var recentlyPlayed: [RecentlyPlayedMusicItem] {
            get async {
                let request = MusicRecentlyPlayedContainerRequest()
                let response = try? await request.response()
                
                if let items = response?.items {
                    return .init(items)
                }
                
                return []
            }
        }
    }
}
