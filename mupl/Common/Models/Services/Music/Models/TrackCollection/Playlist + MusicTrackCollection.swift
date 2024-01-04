//
//  Playlist + MusicTrackCollection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

extension Playlist: MusicTrackCollection {
    var title: String {
        return self.name
    }
    
    var description: String? {
        return self.standardDescription
    }
    
    var authorName: String? {
        return self.curatorName
    }
    
    var releaseDate: Date? {
        return self.lastModifiedDate
    }
    
    var genreNames: [String] {
        return []
    }
    
    var contentRating: ContentRating? {
        return nil
    }
}
