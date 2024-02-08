//
//  HomeRecommendationsSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI

extension HomeSectionProvider {
    struct RecommendationsSection: ProvidableSection {
        func section(with value: [MusicPersonalRecommendationItem]) -> some View {
            VStack(alignment: .leading, spacing: .s8) {
                ForEach(value, id: \.id) { recommendation in
                    switch recommendation.type {
                    case .madeForYou: 
                        MadeForYouRecommendationSection().section(with: recommendation)
                    case .recentlyPlayed, .other:
                        DefaultRecommendationSection().section(with: recommendation)
                    }
                }
            }
        }
        
        func skeleton() -> some View {
            VStack(alignment: .leading, spacing: .s8) {
                MadeForYouRecommendationSection().skeleton()
                DefaultRecommendationSection().skeleton()
                DefaultRecommendationSection().skeleton()
                DefaultRecommendationSection().skeleton()
            }
        }
    }
}

// MARK: - Default

extension HomeSectionProvider.RecommendationsSection {
    struct DefaultRecommendationSection: ProvidableSection {
        func section(with value: MusicPersonalRecommendationItem) -> some View {
            ScrollableSection(title: value.title, items: value.items, id: \.id) { item in
                NavigationLink(value: item) {
                    TrackCollectionItem(item: item, kind: .medium)
                }
                .buttonStyle(.plain)
            }
        }
        
        func skeleton() -> some View {
            ScrollableSection.Skeleton(quantity: 8) {
                TrackCollectionItem.Skeleton(kind: .medium)
            }
        }
    }
}

// MARK: - Made for You

extension HomeSectionProvider.RecommendationsSection {
    struct MadeForYouRecommendationSection: ProvidableSection {
        private struct Item: View {
            private let item: MusicTrackCollection
            
            @State private var isHovered: Bool = false
            
            init(item: MusicTrackCollection) {
                self.item = item
            }
            
            var body: some View {
                ZStack {
                    WebImage(url: self.item.artwork?.url(width: 1080, height: 1080))
                        .resizable()
                        .placeholder {
                            Color.secondaryFill
                        }
                        .scaledToFill()
                        .frame(height: 64.0, alignment: .bottom)
                    
                    Color.black
                        .opacity(self.isHovered ? 0.6 : 0.4)
                    
                    Label(item.title, systemImage: "play.fill")
                        .foregroundStyle(.white)
                        .font(.system(size: 14.0, weight: .bold))
                }
                .frame(height: 64.0)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .clipShape(.rect(cornerRadius: 8.0))
                .border(style: .quinaryFill, width: 2.0, cornerRadius: 8.0)
                .animation(.easeInOut, value: self.isHovered)
                .onHover { hovering in
                    self.isHovered = hovering
                }
            }
            
            struct Skeleton: View {
                var body: some View {
                    Color.tertiaryFill
                        .frame(height: 64.0)
                        .frame(maxWidth: .infinity)
                        .clipShape(.rect(cornerRadius: 8.0))
                }
            }
        }
        
        func section(with value: MusicPersonalRecommendationItem) -> some View {
            VStack(alignment: .leading, spacing: .s3) {
                Text(value.title)
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                HStack(spacing: .s2) {
                    ForEach(value.items, id: \.id) { item in
                        Item(item: item) // <- Item (I think I'm sick)
                    }
                }
            }
        }
        
        func skeleton() -> some View {
            VStack(alignment: .leading, spacing: .s3) {
                Color.tertiaryFill
                    .frame(width: 120.0, height: 16.0)
                    .clipShape(.rect(cornerRadius: 4.0))
                
                HStack(spacing: .s2) {
                    ForEach(0 ..< 4, id: \.self) { item in
                        Item.Skeleton()
                    }
                }
            }
        }
    }
}
