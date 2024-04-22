//
//  MusicPersonalRecommendationItem.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import Foundation
import MusicKit

enum MusicPersonalRecommendationType: String {
    case madeForYou = "6-27s5hU6azhJY"
    case recentlyPlayed = "7-2Tqlz47h9yro"
    case other = "-"
    
    init(id: String) {
        self = MusicPersonalRecommendationType(rawValue: id) ?? .other
    }
}

struct MusicPersonalRecommendationItem: Hashable, Identifiable {
    let type: MusicPersonalRecommendationType
    let title: String
    let items: MusicItemCollection<MusicPersonalRecommendation.Item>
    
    var id: Int {
        return self.hashValue
    }
}
