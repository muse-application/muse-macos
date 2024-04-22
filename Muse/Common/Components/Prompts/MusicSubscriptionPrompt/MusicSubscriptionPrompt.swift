//
//  MusicSubscriptionPrompt.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 09.03.2024.
//

import SwiftUI

struct MusicSubscriptionPrompt: View {
    @State private var isShowingOffer: Bool = false
    
    @EnvironmentObject private var musicManager: MusicManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image("Common/AppleMusic")
                .resizable()
                .scaledToFit()
                .frame(width: 40.0, height: 40.0)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Join Apple Music")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                Text("Listen to over 100 million songs, ad-free with zero commercials. Plus get unlimited downloads to your library, and listen anywhere without Wi-Fi or using data. There’s no commitment, you can cancel anytime.")
                    .font(.system(size: 14.0))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.secondaryText)
            }
            
            Button {
                self.isShowingOffer = true
            } label: {
                Text("Join")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.app(.primary))
        }
        .padding(.all, 24.0)
        .frame(maxWidth: 512.0)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16.0))
        .border(style: .quinaryFill, cornerRadius: 16.0)
        .musicSubscriptionOffer(isPresented: self.$isShowingOffer)
    }
}
