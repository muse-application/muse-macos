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
            ZStack {
                ContentView()
                    .zIndex(0)
                
                if self.musicAuthenticator.status != .authorized {
                    MusicAuthorizationPrompt()
                        .zIndex(1)
                }
            }
            .transition(.opacity)
            .animation(.easeIn(duration: 0.2), value: self.musicAuthenticator.status)
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
                    .keyboardShortcut("Q", modifiers: [.command])
                }
            }
        }
        .windowToolbarStyle(.unified(showsTitle: false))
        .windowStyle(.hiddenTitleBar)
    }
}
