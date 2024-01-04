//
//  TrackCollectionSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import SwiftUI

struct TrackCollectionSection: View {
    private let title: String
    private let items: [any MusicTrackCollection]
    
    init(title: String, items: [any MusicTrackCollection]) {
        self.title = title
        self.items = items
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .s3) {
            Text(self.title)
                .font(.system(size: 16.0, weight: .bold))
                .foregroundStyle(Color.primary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .s4) {
                    ForEach(self.items, id: \.id) { item in
                        TrackCollectionItem(item: item, kind: .medium) { trackCollectionItem in
                            
                        }
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 24.0)
            }
            .scrollTargetBehavior(.viewAligned)
            .padding(.horizontal, -24.0)
        }
    }
}

// MARK: - Skeleton

extension TrackCollectionSection {
    struct Skeleton: View {
        private let quantity: Int
        
        init(quantity: Int) {
            self.quantity = quantity
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: .s3) {
                Color.tertiaryFill
                    .frame(width: 150.0, height: 16.0)
                    .clipShape(.rect(cornerRadius: 4.0))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: .s4) {
                        ForEach(0 ..< self.quantity, id: \.self) { item in
                            TrackCollectionItem.Skeleton(kind: .medium)
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal, 24.0)
                }
                .scrollTargetBehavior(.viewAligned)
                .padding(.horizontal, -24.0)
            }
        }
    }
}
