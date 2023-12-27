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
        ZStack {
            HStack(spacing: .s3) {
                Color.secondaryFill
                    .frame(width: .s9, height: .s9)
                    .clipShape(.rect(cornerRadius: .s2))
                    .border(style: Color.quinaryFill, cornerRadius: .s2)
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text("Song title")
                        .font(.system(size: 12.0, weight: .semibold))
                        .foregroundStyle(Color.primaryText)
                    
                    Text("Artist name")
                        .font(.system(size: 10.0, weight: .medium))
                        .foregroundStyle(Color.secondaryText)
                }
            }
            .tappable(hoverStyle: .init(padding: .init(vertical: .s2, horizontal: .s3), cornerRadius: .s2)) {
                print("Pressed!")
            }
        }
        .frame(minWidth: 240.0)
    }
}

#Preview {
    PlaybarSongPreview()
        .padding()
}
