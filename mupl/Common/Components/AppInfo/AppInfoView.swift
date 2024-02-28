//
//  AppInfoView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.02.2024.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        VStack(spacing: 16.0) {
            VStack(spacing: 8.0) {
                Image("Common/Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80.0, height: 80.0)
                    .clipShape(.rect(cornerRadius: 16.0))
                
                Text(Bundle.main.appName)
                    .font(.system(size: 24.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
            }
            
            VStack(spacing: 4.0) {
                Text("Version: \(Bundle.main.versionNumber)")
                    .font(.system(size: 14.0, weight: .medium))
                
                Text("Licensed under MIT license.")
                    .font(.system(size: 12.0))
            }
            .foregroundStyle(Color.secondaryText)
            
            Image("Common/GitHub")
                .resizable()
                .scaledToFit()
                .frame(width: 32.0, height: 32.0)
                .tappable {
                    if let url = URL(string: "https://github.com/mupl-app/mupl-macos") {
                        NSWorkspace.shared.open(url)
                    }
                }
        }
        .frame(width: 400.0, height: 400.0)
    }
}
