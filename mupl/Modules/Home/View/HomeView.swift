//
//  HomeView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.12.2023.
//

import SwiftUI

struct HomeView: View {
    private enum Constants {
        static let padding: CGFloat = 24.0
        static let bottomPadding: CGFloat = 70.0 + Self.padding
    }
    
    private let sectionProvider: HomeSectionProvider = .init()
    
    @EnvironmentObject private var musicCatalog: MusicCatalog
    
    @State private var recentlyPlayed: [any MusicTrackCollection] = []
    @State private var recommendations: [MusicPersonalRecommendationItem] = []
    @State private var loadingState: LoadingState = .idle
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .s6) {
                Text("Listen Now")
                    .font(.system(size: 32.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                Group {
                    switch self.loadingState {
                    case .idle, .loading:
                        self.sectionProvider.skeleton(for: \.recommendations)
                    case .loaded:
                        self.sectionProvider.section(for: \.recommendations, value: self.recommendations)
                    }
                }
                .transition(.opacity)
            }
            .padding([.top, .horizontal], Constants.padding)
            .padding(.bottom, Constants.bottomPadding)
            .animation(.easeInOut, value: self.loadingState)
        }
        .scrollDisabled(self.loadingState != .loaded)
        .task {
            self.loadingState = .loading
            
            self.recentlyPlayed = await self.musicCatalog.personal.recentlyPlayed
            self.recommendations = await self.musicCatalog.personal.recommendations
            
            self.loadingState = .loaded
        }
    }
}
