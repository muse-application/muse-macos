//
//  Artist.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 27.02.2024.
//

import MusicKit

extension Artist {
    static func named(_ name: String) async throws -> Artist {
        let request = MusicCatalogSearchRequest(term: name, types: [Artist.self])
        let response = try await request.response()
        
        guard let artist = response.artists.first else { throw AppError.unknown }
        
        return artist
    }
}
