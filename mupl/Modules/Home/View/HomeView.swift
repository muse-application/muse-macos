//
//  HomeView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.12.2023.
//

import SwiftUI

struct HomeView: View {
    private let sectionProvider: HomeSectionProvider = .init()
    
    @EnvironmentObject private var musicCatalog: MusicCatalog
    
    @State private var recommendations: [MusicPersonalRecommendationItem] = []
    @State private var charts: MusicChartsCompilation?
    @State private var loadingState: LoadingState = .idle
    
    var body: some View {
        ScrollView {
            ZStack {
                LazyVStack(alignment: .leading, spacing: .s6) {
                    Text("Listen Now")
                        .font(.system(size: 32.0, weight: .bold))
                        .foregroundStyle(Color.primaryText)
                    
                    Group {
                        switch self.loadingState {
                        case .idle, .loading:
                            self.skeleton
                        case .loaded:
                            self.content
                        }
                    }
                    .transition(.opacity)
                }
                .padding(.all, 24.0)
                .frame(minWidth: 500.0, maxWidth: 1080.0, alignment: .top)
                .animation(.easeInOut, value: self.loadingState)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 70.0)
        .scrollDisabled(self.loadingState != .loaded)
        .task {
            self.loadingState = .loading
            
            self.recommendations = await self.musicCatalog.personal.recommendations
            self.charts = await self.musicCatalog.charts.compilation
            
            self.loadingState = .loaded
        }
    }
    
    // MARK: - Content
    
    private var content: some View {
        Group {
            self.sectionProvider.section(for: \.recommendations, value: self.recommendations)
            
            if let charts = self.charts {
                self.sectionProvider.section(for: \.charts, value: charts)
            }
        }
    }
    
    private var skeleton: some View {
        Group {
            self.sectionProvider.skeleton(for: \.recommendations)
            self.sectionProvider.skeleton(for: \.charts)
        }
    }
}
