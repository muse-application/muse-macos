//
//  SearchResultsTopResultsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI
import MusicKit

extension SearchResultsSectionProvider {
    struct TopResultsSection: ProvidableSection {
        struct TopItem: View {
            private let title: String
            private let type: String
            private let artwork: Artwork?
            
            init(title: String, type: String, artwork: Artwork?) {
                self.title = title
                self.type = type
                self.artwork = artwork
            }
            
            var body: some View {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        MusicArtworkImage(artwork: self.artwork)
                            .frame(width: 100.0, height: 100.0)
                            .clipShape(.rect(cornerRadius: 8.0))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 12.0, weight: .medium))
                            .foregroundStyle(Color.secondaryText)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0.0) {
                        Text(self.type)
                            .font(.system(size: 12.0, weight: .regular))
                            .foregroundStyle(Color.secondaryText)
                        
                        Text(self.title)
                            .font(.system(size: 14.0, weight: .semibold))
                            .foregroundStyle(Color.primaryText)
                    }
                }
                .padding(.all, 12.0)
                .frame(width: 200.0)
                .background(Color.quinaryFill)
                .clipShape(.rect(cornerRadius: 8.0))
            }
        }
        
        func section(with value: MusicSearchResults.TopResults) -> some View {
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Top Results")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                HStack(spacing: 16.0) {
                    if let topItem = value.topItem {
                        switch topItem {
                        case .artist(let artist):
                            NavigationLink(value: artist) {
                                TopItem(title: artist.name, type: "Artist", artwork: artist.artwork)
                            }
                            .buttonStyle(.plain)
                        case .album(let album):
                            NavigationLink(value: album) {
                                TopItem(title: album.title, type: "Album", artwork: album.artwork)
                            }
                            .buttonStyle(.plain)
                        case .playlist(let playlist):
                            NavigationLink(value: playlist) {
                                TopItem(title: playlist.name, type: "Playlist", artwork: playlist.artwork)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    VStack(spacing: 8.0) {
                        ForEach(value.songs) { song in
                            SongItem(song: song)
                        }
                    }
                }
            }
        }
        
        func skeleton() -> some View {
            VStack {
                
            }
        }
    }
}
