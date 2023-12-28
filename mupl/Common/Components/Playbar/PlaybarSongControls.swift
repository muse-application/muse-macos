//
//  PlaybarSongControls.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct PlaybarSongControls: View {
    var body: some View {
        VStack(spacing: 8.0) {
            HStack(spacing: 8.0) {
                Image(systemName: "shuffle")
                    .font(.system(size: 10.0, weight: .medium))
                
                Group {
                    Image(systemName: "backward.fill")
                    Image(systemName: "play.fill")
                    Image(systemName: "forward.fill")
                }
                .font(.system(size: 14.0, weight: .medium))
                
                Image(systemName: "repeat")
                    .font(.system(size: 10.0, weight: .medium))
            }
            .foregroundStyle(.secondary)
            
            Slider(width: .flexible(min: 320.0, ideal: 320.0, max: 500.0))
        }
    }
}

#Preview {
    PlaybarSongControls()
        .padding()
}
