//
//  Playbar.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct Playbar: View {
    static let height: CGFloat = 70.0
    
    @State private var isQueueBarPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: .zero) {
                SongPreview()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SongControls()
                    .frame(maxWidth: .infinity)
                
                VolumeControls()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Image(systemName: "list.bullet")
                    .font(.system(size: 18.0))
                    .tappable {
                        self.isQueueBarPresented.toggle()
                    }
            }
            .padding(.horizontal, 16.0)
            .frame(height: Self.height)
            .frame(maxWidth: .infinity)
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 12.0))
            .border(style: .quinaryFill, cornerRadius: 12.0)
            
            QueueBar(isPresented: self.$isQueueBarPresented)
                .padding(.top, 24.0)
                .padding(.bottom, Self.height + 24.0)
        }
    }
}
