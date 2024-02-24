//
//  TrackCollectionItem.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import SwiftUI
import MusicKit

struct TrackCollectionItem: View {
    enum Kind {
        case medium
        case large
        
        var size: CGSize {
            switch self {
            case .medium:
                return .init(width: 200.0, height: 200.0)
            case .large:
                return .init(width: 256.0, height: 256.0)
            }
        }
    }
    
    private let item: any MusicTrackCollection
    private let kind: Kind
    private let onTapAction: ((any MusicTrackCollection) -> Void)?
    
    @State private var isHovered: Bool = false
    
    @EnvironmentObject private var musicPlayer: MusicPlayer
    
    init(item: any MusicTrackCollection, kind: Kind, onTap action: ((any MusicTrackCollection) -> Void)? = nil) {
        self.item = item
        self.kind = kind
        self.onTapAction = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .s1) {
            ZStack(alignment: .bottomLeading) {
                MusicArtworkImage(artwork: self.item.artwork)
                    .zIndex(0)
                
                if self.isHovered {
                    Group {
                        Color.black.opacity(0.4)
                            .zIndex(1)
                        
                        Button {
                            self.musicPlayer.play(item: self.item)
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 24.0))
                        }
                        .buttonStyle(.systemHoverable())
                        .padding([.leading, .bottom], 8.0)
                        .zIndex(2)
                    }
                    .transition(.opacity)
                }
            }
            .frame(width: self.kind.size.width, height: self.kind.size.height)
            .clipShape(.rect(cornerRadius: 8.0))
            .border(style: .quinaryFill, cornerRadius: 8.0)
            .animation(.easeInOut, value: self.isHovered)
            
            VStack(alignment: .leading, spacing: 2.0) {
                Text(self.item.title)
                    .lineLimit(1)
                    .font(.system(size: 12.0, weight: .medium))
                    .foregroundStyle(Color.primaryText)
                
                if let authorName = self.item.authorName {
                    Text(authorName)
                        .lineLimit(1)
                        .font(.system(size: 12.0, weight: .regular))
                        .foregroundStyle(Color.secondaryText)
                }
            }
            .frame(width: self.kind.size.width, alignment: .leading)
        }
        .onHover { hovering in
            self.isHovered = hovering
        }
    }
}

// MARK: - Skeleton

extension TrackCollectionItem {
    struct Skeleton: View {
        private let kind: Kind
        
        init(kind: Kind) {
            self.kind = kind
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: .s1) {
                Color.tertiaryFill
                    .frame(width: self.kind.size.width, height: self.kind.size.height)
                    .clipShape(.rect(cornerRadius: 8.0))
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Color.tertiaryFill
                        .frame(width: self.kind.size.width * 0.8, height: 12.0)
                        .clipShape(.rect(cornerRadius: 4.0))
                    
                    Color.tertiaryFill
                        .frame(width: self.kind.size.width * 0.4, height: 12.0)
                        .clipShape(.rect(cornerRadius: 4.0))
                }
            }
        }
    }
}
