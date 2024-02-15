//
//  muplApp.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 07.12.2023.
//

import SwiftUI

@main
struct muplApp: App {
    @StateObject private var musicAuthenticator: MusicAuthenticator = .init()
    @StateObject private var musicCatalog: MusicCatalog = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await self.musicAuthenticator.requestIfNeeded()
                }
        }
        .environmentObject(self.musicAuthenticator)
        .environmentObject(self.musicCatalog)
        .windowStyle(.hiddenTitleBar)
    }
}
