//
//  Playbar.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct Playbar: View {
    var body: some View {
        HStack(spacing: 0.0) {
            PlaybarSongPreview()
                .frame(maxWidth: .infinity)
            
            PlaybarSongControls()
                .frame(maxWidth: .infinity)
            
            PlaybarVolumeControls()
                .frame(maxWidth: .infinity)
        }
        .frame(height: 70.0)
        .frame(maxWidth: .infinity)
        .background(.ultraThickMaterial)
    }
}

#Preview {
    Playbar()
        .frame(width: 800.0)
        .padding()
}
