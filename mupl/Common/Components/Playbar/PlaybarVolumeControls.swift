//
//  PlaybarVolumeControls.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 29.12.2023.
//

import SwiftUI

struct PlaybarVolumeControls: View {
    var body: some View {
        HStack(spacing: 8.0) {
            Image(systemName: "speaker.fill")
                .font(.system(size: 10.0, weight: .medium))
            
            Slider(width: .constant(64.0))
            
            Image(systemName: "speaker.wave.3.fill")
                .font(.system(size: 10.0, weight: .medium))
        }
        .frame(minWidth: 240.0)
    }
}

#Preview {
    PlaybarVolumeControls()
        .padding()
}
