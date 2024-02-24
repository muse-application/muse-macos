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
        var recommendations: [MusicPersonalRecommendationItem] {
            get async {
                let request = MusicPersonalRecommendationsRequest()
                let response = try? await request.response()
                
                if let recommendations = response?.recommendations {
                    return recommendations
                        .compactMap { recommendation in
                            guard !recommendation.items.isEmpty else { return nil }
                            
                            return .init(
                                type: .init(id: recommendation.id.rawValue),
                                title: recommendation.title ?? "Recommended for You",
                                items: recommendation.items
                            )
                        }
                }
                
                return []
            }
        }
    }
}
