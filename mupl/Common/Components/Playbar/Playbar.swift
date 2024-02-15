//
//  Playbar.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct Playbar: View {
    @Environment(\.playbarHeight) private var playbarHeight
    
    @State private var isQueueBarPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: .zero) {
                PlaybarSongPreview()
                    .frame(maxWidth: .infinity)
                
                PlaybarSongControls()
                    .frame(maxWidth: .infinity)
                
                PlaybarVolumeControls()
                    .frame(maxWidth: .infinity)
                
                Image(systemName: "list.bullet")
                    .font(.system(size: 18.0))
                    .tappable {
                        self.isQueueBarPresented.toggle()
                    }
            }
            .padding(.horizontal, 16.0)
            .frame(height: self.playbarHeight)
            .frame(maxWidth: .infinity)
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 12.0))
            .border(style: .quinaryFill, cornerRadius: 12.0)
            
            QueueBar(isPresented: self.$isQueueBarPresented)
                .padding(.top, 24.0)
                .padding(.bottom, self.playbarHeight + 24.0)
        }
    }
}
