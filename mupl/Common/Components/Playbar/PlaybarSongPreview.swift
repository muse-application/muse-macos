//
//  PlaybarSongPreview.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

#warning("TODO: Add Song injection")
struct PlaybarSongPreview: View {
    var body: some View {
        HStack(spacing: .s3) {
            Color.secondary
                .frame(width: .s9, height: .s9)
                .clipShape(.rect(cornerRadius: .s2))
                .border(style: .quinary, cornerRadius: .s2)
            
            VStack(alignment: .leading, spacing: .zero) {
                Text("Song title")
                    .font(.system(size: .s3, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Text("Artist name")
                    .font(.system(size: 10.0, weight: .medium))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(minWidth: 240.0)
    }
}

#Preview {
    PlaybarSongPreview()
        .padding()
}
