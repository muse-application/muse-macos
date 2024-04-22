//
//  MusicCatalogGenres.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import Foundation
import MusicKit

extension MusicCatalog {
    struct Genres {
        var trending: [Genre] {
            get async {
                guard
                    let countryCode = try? await MusicDataRequest.currentCountryCode,
                    let url = URL(string: "https://api.music.apple.com/v1/catalog/\(countryCode)/genres?limit=12"),
                    let response = try? await MusicDataRequest(urlRequest: .init(url: url)).response(),
                    let genres = try? JSONDecoder().decode(MusicItemCollection<Genre>.self, from: response.data)
                else {
                    return []
                }
                
                return .init(genres)
            }
        }
    }
}
