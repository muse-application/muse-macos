//
//  SearchResultsSectionProvider.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import Foundation

struct SearchResultsSectionProvider: SectionProvider {
    let topResults: TopResultsSection = .init()
    let artists: ArtistsSection = .init()
    let albums: AlbumsSection = .init()
    let playlists: PlaylistsSection = .init()
    let songs: SongsSection = .init()
}
