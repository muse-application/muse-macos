//
//  MusicSearchResults.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 11.02.2024.
//

import Foundation
import MusicKit

struct MusicSearchResults: Hashable {
    struct TopResults: Hashable {
        enum TopItem: Hashable {
            case artist(Artist)
            case album(Album)
            case playlist(Playlist)
        }
        
        let topItem: TopItem?
        let songs: MusicItemCollection<Song>
    }
    
    let topResults: TopResults
    let artists: MusicItemCollection<Artist>
    let albums: MusicItemCollection<Album>
    let playlists: MusicItemCollection<Playlist>
    let songs: MusicItemCollection<Song>
    
    init(
        topResults: TopResults,
        artists: MusicItemCollection<Artist>,
        albums: MusicItemCollection<Album>,
        playlists: MusicItemCollection<Playlist>,
        songs: MusicItemCollection<Song>
    ) {
        self.topResults = topResults
        self.artists = artists
        self.albums = albums
        self.playlists = playlists
        self.songs = songs
    }
    
    init(response: MusicCatalogSearchResponse) {
        let topItem: TopResults.TopItem? = switch response.topResults.first {
            case .artist(let artist): .artist(artist)
            case .album(let album): .album(album)
            case .playlist(let playlist): .playlist(playlist)
            default: nil
        }
        
        let topSongs: MusicItemCollection<Song> = .init(
            response.topResults
                .compactMap { result in
                    guard case .song(let song) = result else { return nil }
                    return song
                }
                .prefix(4)
        )
        
        self.topResults = .init(topItem: topItem, songs: topSongs)
        self.artists = response.artists
        self.albums = response.albums
        self.playlists = response.playlists
        self.songs = response.songs
    }
}
