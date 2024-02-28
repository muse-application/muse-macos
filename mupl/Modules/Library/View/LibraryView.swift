//
//  LibraryView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI
import MusicKit

struct LibraryView: View {
    private enum FilterType: Int, Hashable {
        case albums = 0
        case playlists
    }
    
    @State private var filterType: FilterType = .albums
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8.0) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Library")
                        .font(.system(size: 32.0, weight: .bold))
                        .foregroundStyle(Color.primaryText)
                    
                    Chips(
                        items: [
                            .init(title: "Albums", value: .albums),
                            .init(title: "Playlists", value: .playlists)
                        ],
                        selection: self.$filterType
                    )
                }
                .padding([.top, .horizontal], 24.0)
                
                switch self.filterType {
                case .albums:
                    TrackCollectionList<Album>()
                case .playlists:
                    TrackCollectionList<Playlist>()
                }
            }
            .navigationDestination(for: Artist.self) { artist in
                ArtistDetailsView(artist: artist)
            }
            .navigationDestination(for: Album.self) { album in
                AlbumDetailsView(album: album)
            }
            .navigationDestination(for: Playlist.self) { playlist in
                PlaylistDetailsView(playlist: playlist)
            }
        }
    }
}
