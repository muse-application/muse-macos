//
//  MusicAuthorizationPrompt.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.02.2024.
//

import SwiftUI

struct MusicAuthorizationPrompt: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16.0) {
                Image("Common/Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40.0, height: 40.0)
                    .clipShape(.rect(cornerRadius: 12.0))
                
                VStack(spacing: 16.0) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("Music access required")
                            .font(.system(size: 16.0, weight: .bold))
                            .foregroundStyle(Color.primaryText)
                        
                        Text("Granting permission allows us to enhance your experience by accessing your music library. We prioritize your privacy and will only utilize this access for its intended purpose.")
                            .font(.system(size: 14.0))
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Color.secondaryText)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Allow access")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.app(.primary))
                }
            }
            .padding(.all, 24.0)
            .frame(maxWidth: 512.0)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 16.0))
            .border(style: .quinaryFill, cornerRadius: 16.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
