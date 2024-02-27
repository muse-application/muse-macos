//
//  AppInfo.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.02.2024.
//

import SwiftUI

struct AppInfo: View {
    static let height: CGFloat = 16.0
    
    var body: some View {
        HStack {
            HStack(spacing: 8.0) {
                Text(Bundle.main.versionNumber)
                    .font(.system(size: 12.0))
                
                Text("BETA")
                    .font(.system(size: 8.0, weight: .bold))
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 2.0)
                    .padding(.horizontal, 4.0)
                    .background(Color.pinkAccent)
                    .clipShape(.rect(cornerRadius: 8.0))
            }
            
            Spacer()
            
            HStack(spacing: 4.0) {
                Text("Contribute")
                    .font(.system(size: 12.0))
                    .tappable(hoverStyle: .init(padding: .init(vertical: 4.0, horizontal: 4.0))) {
                        if let url = URL(string: "https://github.com/mupl-app/mupl-macos") {
                            NSWorkspace.shared.open(url)
                        }
                    }
                
                Text("Report a bug")
                    .font(.system(size: 12.0))
                    .tappable(hoverStyle: .init(padding: .init(vertical: 4.0, horizontal: 4.0))) {
                        if let url = URL(string: "https://github.com/mupl-app/mupl-macos/issues/new") {
                            NSWorkspace.shared.open(url)
                        }
                    }
            }
        }
        .foregroundStyle(Color.secondaryText)
        .padding(.horizontal, 24.0)
        .frame(height: Self.height)
    }
}
