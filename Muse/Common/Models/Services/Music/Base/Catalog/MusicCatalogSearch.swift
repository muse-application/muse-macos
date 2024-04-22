//
//  MusicCatalogSearch.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import Foundation
import MusicKit

extension MusicCatalog {
    struct Search {
        func request(term: String, types: [MusicCatalogSearchable.Type]) async throws -> MusicSearchResults {
            var request = MusicCatalogSearchRequest(term: term, types: types)
            
            request.includeTopResults = true
            request.limit = 12
            
            return .init(response: try await request.response())
        }
    }
}
