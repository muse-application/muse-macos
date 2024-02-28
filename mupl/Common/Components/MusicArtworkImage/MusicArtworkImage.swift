//
//  MusicArtworkImage.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 08.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
import MusicKit

struct MusicArtworkImage: View {
    private let artwork: Artwork?
    private let width: CGFloat
    private let height: CGFloat
    
    @State private var isFailed: Bool = false
    
    init(artwork: Artwork?, width: CGFloat, height: CGFloat) {
        self.artwork = artwork
        self.width = width
        self.height = height
    }
    
    var body: some View {
        if let artwork = self.artwork {
            self.artworkImage(artwork)
        } else {
            self.placeholder
        }
    }
    
    // MARK: - Components
    
    private var placeholder: some View {
        ZStack {
            Color.secondaryFill
            
            Image(systemName: "music.note")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.primaryText)
                .padding(.all, 12.0)
                .frame(maxWidth: 64.0, maxHeight: 64.0)
        }
    }
    
    @ViewBuilder
    private func artworkImage(_ artwork: Artwork) -> some View {
        if self.isFailed {
            ArtworkImage(artwork, width: self.width, height: self.height)
        } else {
            WebImage(url: artwork.url(width: Int(self.width), height: Int(self.height)))
                .resizable()
                .placeholder {
                    self.placeholder
                }
                .onFailure { _ in
                    self.isFailed = true
                }
                .frame(width: self.width, height: self.height)
        }
    }
}
