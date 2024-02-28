//
//  muplApp.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 07.12.2023.
//

import SwiftUI

@main
struct muplApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var musicAuthenticator: MusicAuthenticator = .init()
    @StateObject private var musicCatalog: MusicCatalog = .init()
    @StateObject private var musicPlayer: MusicPlayer = .init()
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
        .environmentObject(self.musicPlayer)
        .environmentObject(self.router)
        .commandsRemoved()
        .commands {
            CommandGroup(replacing: .appInfo) {
                Section {
                    Button("About \(Bundle.main.appName)") {
                        self.appDelegate.showAppInfo()
                    }
                }
                
                Section {
                    Button("Quit \(Bundle.main.appName)") {
                        NSApplication.shared.terminate(nil)
                    }
                }
            }
        }
        .windowToolbarStyle(.unified(showsTitle: false))
        .windowStyle(.hiddenTitleBar)
    }
}
