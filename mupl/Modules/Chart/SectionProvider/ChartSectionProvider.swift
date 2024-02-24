//
//  ChartSectionProvider.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

struct ChartSectionProvider: SectionProvider {
    let albums: AlbumsSection = .init()
    let playlists: PlaylistsSection = .init()
    let songs: SongsSection = .init()
}
