//
//  AppInfoView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.02.2024.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(alignment: .top, spacing: 24.0) {
                Image("Common/Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100.0, height: 100.0)
                    .clipShape(.rect(cornerRadius: 24.0))
                
                VStack(alignment: .leading, spacing: 0.0) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(Bundle.main.appName)
                            .font(.system(size: 24.0, weight: .bold))
                            .foregroundStyle(Color.primaryText)
                        
                        Text("Apple Music player for macOS.")
                            .font(.system(size: 16.0))
                            .foregroundStyle(Color.secondaryText)
                    }
                    
                    Spacer()
                    
                    Text("Version: \(Bundle.main.versionNumber)")
                        .font(.system(size: 14.0))
                }
            }
            .frame(height: 100.0)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            VStack(spacing: 2.0) {
                Text("GitHub")
                    .foregroundStyle(Color.pinkAccent)
                    .tappable(hoverStyle: .init(padding: .init(vertical: 2.0, horizontal: 4.0))) {
                        if let url = URL(string: "https://github.com/mupl-app/mupl-macos") {
                            NSWorkspace.shared.open(url)
                        }
                    }
                
                Text("Licensed under MIT. Crafted with <3")
                    .font(.system(size: 10.0))
                    .foregroundStyle(Color.secondaryText)
            }
        }
        .padding(.all, 24.0)
        .frame(width: 512.0, height: 216.0)
    }
}
