//
//  MusicPersonalRecommendationItem.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import Foundation

struct MusicPersonalRecommendationItem: Hashable, Identifiable {
    let title: String
    let items: [any MusicTrackCollection]
    
    var id: Int {
        return self.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
        self.items.forEach { hasher.combine($0) }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
