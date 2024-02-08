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
                .frame(
                    minWidth: 1024.0,
                    idealWidth: 1024.0,
                    minHeight: 600.0,
                    idealHeight: 600.0
                )
                .task {
                    await self.musicAuthenticator.requestIfNeeded()
                }
        }
        .environmentObject(self.musicAuthenticator)
        .environmentObject(self.musicCatalog)
        .windowToolbarStyle(.unified(showsTitle: false))
    }
}
