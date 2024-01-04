//
//  Station + MusicTrackCollection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

extension Station: MusicTrackCollection {
    var title: String {
        return self.name
    }
    
    var description: String? {
        return self.editorialNotes?.standard
    }
    
    var authorName: String? {
        return self.stationProviderName
    }
    
    var releaseDate: Date? {
        return nil
    }
    
    var genreNames: [String] {
        return []
    }
    
    var tracks: MusicItemCollection<Track>? {
        return nil
    }
}
