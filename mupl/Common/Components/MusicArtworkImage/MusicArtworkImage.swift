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
    
    init(artwork: Artwork?) {
        self.artwork = artwork
    }
    
    var body: some View {
        WebImage(url: self.artwork?.url(width: 512, height: 512))
            .resizable()
            .placeholder {
                ZStack {
                    Color.secondaryFill
                    
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.primaryText)
                        .padding(.all, 12.0)
                }
            }
    }
}
