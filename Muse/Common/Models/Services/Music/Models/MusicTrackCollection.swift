//
//  MusicTrackCollection.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

/**
 A common protocol that describes some track collection,
 e.g. album, playlist, station
 */
protocol MusicTrackCollection: Hashable, Identifiable, PlayableMusicItem {
    var id: MusicItemID { get }
    var title: String { get }
    var description: String? { get }
    var artwork: Artwork? { get }
    var authorName: String? { get }
    var releaseDate: Date? { get }
    var genreNames: [String] { get }
    var contentRating: ContentRating? { get }
    var tracks: MusicItemCollection<Track>? { get }
}

extension Album: MusicTrackCollection {
    var authorName: String? {
        return self.artistName
    }
    
    var description: String? {
        return self.editorialNotes?.standard
    }
}

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
