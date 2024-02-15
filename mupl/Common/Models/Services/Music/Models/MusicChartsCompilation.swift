//
//  MusicChartsCompilation.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import Foundation
import MusicKit

struct MusicChartsCompilation: Hashable {
    let topSongs: MusicCatalogChart<Song>?
    let mostPlayedAlbums: MusicCatalogChart<Album>?
    let mostPlayedPlaylists: MusicCatalogChart<Playlist>?
    let dailyGlobalTopPlaylists: MusicCatalogChart<Playlist>?
    let cityTopPlaylists: MusicCatalogChart<Playlist>?
}
