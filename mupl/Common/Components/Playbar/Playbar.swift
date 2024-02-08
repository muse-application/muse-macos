//
//  Playbar.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct Playbar: View {
    @Environment(\.playbarHeight) private var playbarHeight
    
    var body: some View {
        VStack(spacing: 0.0) {
            Divider()
            
            HStack(spacing: .zero) {
                PlaybarSongPreview()
                    .frame(maxWidth: .infinity)
                
                PlaybarSongControls()
                    .frame(maxWidth: .infinity)
                
                PlaybarVolumeControls()
                    .frame(maxWidth: .infinity)
            }
            .frame(height: self.playbarHeight)
            .frame(maxWidth: .infinity)
            .background(.ultraThickMaterial)
        }
    }
}

#Preview {
    Playbar()
        .frame(width: 800.0)
        .padding()
}
