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
struct MusicTrackCollection: Hashable, Identifiable {
    let id: MusicItemID
    let title: String
    let description: String?
    let artwork: Artwork?
    let authorName: String?
    let releaseDate: Date?
    let genreNames: [String]
    let contentRating: ContentRating?
    let songsProvider: @Sendable () async -> [Song]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: MusicTrackCollection, rhs: MusicTrackCollection) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension MusicTrackCollection {
    init(album: Album) {
        self.init(
            id: album.id,
            title: album.title,
            description: album.editorialNotes?.standard,
            artwork: album.artwork,
            authorName: album.artistName,
            releaseDate: album.releaseDate,
            genreNames: album.genreNames,
            contentRating: album.contentRating,
            songsProvider: {
                let tracks = (try? await album.with(.tracks))?.tracks ?? []
                return tracks.compactMap { track in
                    guard case .song(let song) = track else { return nil }
                    return song
                }
            }
        )
    }
    
    init(playlist: Playlist) {
        self.init(
            id: playlist.id,
            title: playlist.name,
            description: playlist.standardDescription,
            artwork: playlist.artwork,
            authorName: playlist.curatorName,
            releaseDate: playlist.lastModifiedDate,
            genreNames: [],
            contentRating: nil,
            songsProvider: {
                let tracks = (try? await playlist.with(.tracks))?.tracks ?? []
                return tracks.compactMap { track in
                    guard case .song(let song) = track else { return nil }
                    return song
                }
            }
        )
    }
    
    init(station: Station) {
        self.init(
            id: station.id,
            title: station.name,
            description: station.editorialNotes?.standard,
            artwork: station.artwork,
            authorName: station.stationProviderName,
            releaseDate: nil,
            genreNames: [],
            contentRating: station.contentRating,
            songsProvider: {
                return []
            }
        )
    }
}
