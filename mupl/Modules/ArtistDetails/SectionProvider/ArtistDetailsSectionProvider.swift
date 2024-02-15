//
//  ArtistDetailsSectionProvider.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import Foundation

struct ArtistDetailsSectionProvider: SectionProvider {
    let latestRelease: LatestReleaseSection = .init()
    let topSongs: TopSongsSection = .init()
    let featuredAlbums: FeaturedAlbumsSection = .init()
    let albums: AlbumsSection = .init()
    let playlists: PlaylistsSection = .init()
}
