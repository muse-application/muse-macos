//
//  ChartView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

struct ChartView: View {
    private let genre: Genre
    private let sectionProvider: ChartSectionProvider = .init()
    
    @EnvironmentObject private var musicCatalog: MusicCatalog
    
    @State private var charts: LoadableValue<MusicChartsCompilation> = .init()
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16.0) {
                Text(self.genre.name)
                    .font(.system(size: 32.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                Group {
                    switch self.charts.status {
                    case .idle, .loading:
                        self.skeleton
                    case .loaded(let charts):
                        self.content(charts)
                    case .error:
                        Color.clear
                    }
                }
                .transition(.opacity)
            }
            .padding(.all, 24.0)
            .animation(.easeIn, value: self.charts.status)
        }
        .scrollDisabled(!self.charts.status.isLoaded)
        .task {
            self.charts.load {
                await self.musicCatalog.charts.compilation(for: self.genre)
            }
        }
    }
    
    // MARK: - Components
    
    private var skeleton: some View {
        LazyVStack(alignment: .leading, spacing: 16.0) {
            self.sectionProvider.skeleton(for: \.albums)
            self.sectionProvider.skeleton(for: \.playlists)
            self.sectionProvider.skeleton(for: \.playlists)
            self.sectionProvider.skeleton(for: \.songs)
        }
    }
    
    private func content(_ charts: MusicChartsCompilation) -> some View {
        LazyVStack(alignment: .leading, spacing: 16.0) {
            if let mostPlayedAlbums = charts.mostPlayedAlbums {
                self.sectionProvider.section(for: \.albums, value: mostPlayedAlbums)
            }
            
            if let mostPlayedPlaylists = charts.mostPlayedPlaylists {
                self.sectionProvider.section(for: \.playlists, value: mostPlayedPlaylists)
            }
            
            if let topSongs = charts.topSongs {
                self.sectionProvider.section(for: \.songs, value: topSongs)
            }
            
            if let dailyGlobalTopPlaylists = charts.dailyGlobalTopPlaylists {
                self.sectionProvider.section(for: \.playlists, value: dailyGlobalTopPlaylists)
            }
            
            if let cityTopPlaylists = charts.cityTopPlaylists {
                self.sectionProvider.section(for: \.playlists, value: cityTopPlaylists)
            }
        }
    }
}
