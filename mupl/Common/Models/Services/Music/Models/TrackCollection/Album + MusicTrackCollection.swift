//
//  Album + MusicTrackCollection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

extension Album: MusicTrackCollection {
    var authorName: String? {
        return self.artistName
    }
    
    var description: String? {
        return self.editorialNotes?.standard
    }
}
