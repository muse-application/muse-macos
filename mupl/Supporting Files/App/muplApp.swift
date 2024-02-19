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
    @StateObject private var router: Router = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await self.musicAuthenticator.requestIfNeeded()
                }
        }
        .environmentObject(self.musicAuthenticator)
        .environmentObject(self.musicCatalog)
        .environmentObject(self.router)
        .windowToolbarStyle(.unified(showsTitle: false))
        .windowStyle(.hiddenTitleBar)
    }
}
