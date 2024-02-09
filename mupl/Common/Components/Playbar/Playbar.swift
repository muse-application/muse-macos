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
        .clipShape(.rect(cornerRadius: 12.0))
        .border(style: .quinaryFill, cornerRadius: 12.0)
    }
}

#Preview {
    Playbar()
        .frame(width: 800.0)
        .padding()
}
