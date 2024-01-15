//
//  MusicTrackCollection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

/**
 A common protocol that describes some track collection,
 e.g. album, playlist, station
 */
protocol MusicTrackCollection: Hashable, Identifiable {
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

extension MusicTrackCollection {
    var songs: [Song] {
        guard let tracks = self.tracks else { return [] }
        
        return tracks.compactMap { track in
            guard case .song(let song) = track else { return nil }
            return song
        }
    }
}
