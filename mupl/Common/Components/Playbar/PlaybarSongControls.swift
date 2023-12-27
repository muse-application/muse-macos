//
//  PlaybarSongControls.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct PlaybarSongControls: View {
    var body: some View {
        VStack(spacing: .s2) {
            HStack(spacing: .s2) {
                Image(systemName: "shuffle")
                    .font(.system(size: 10.0, weight: .medium))
                    .foregroundStyle(Color.secondaryText)
                    .tappable { }
                
                Group {
                    Image(systemName: "backward.fill")
                        .foregroundStyle(Color.secondaryText)
                        .tappable { }
                    
                    Image(systemName: "play.fill")
                        .foregroundStyle(Color.secondaryText)
                        .tappable { }
                    
                    Image(systemName: "forward.fill")
                        .foregroundStyle(Color.secondaryText)
                        .tappable { }
                }
                .font(.system(size: 14.0, weight: .medium))
                
                Image(systemName: "repeat")
                    .font(.system(size: 10.0, weight: .medium))
                    .foregroundStyle(Color.secondaryText)
                    .tappable { }
            }
            .frame(height: 24.0)
            
            Slider(width: .flexible(min: 320.0, ideal: 320.0, max: 500.0))
        }
    }
}

#Preview {
    PlaybarSongControls()
        .padding()
}
