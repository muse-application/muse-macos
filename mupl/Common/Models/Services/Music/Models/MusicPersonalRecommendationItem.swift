//
//  MusicPersonalRecommendationItem.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import Foundation

enum MusicPersonalRecommendationType: String {
    case madeForYou = "6-27s5hU6azhJY"
    case recentlyPlayed = "7-2Tqlz47h9yro"
    case stationsForYou = "20-3fkE98c8EUE3TlhgANBAwh"
    case other = "-"
    
    init(id: String) {
        self = MusicPersonalRecommendationType(rawValue: id) ?? .other
    }
}

struct MusicPersonalRecommendationItem: Hashable, Identifiable {
    let type: MusicPersonalRecommendationType
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
