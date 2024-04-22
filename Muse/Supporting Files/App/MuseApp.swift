//
//  MuseApp.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 07.12.2023.
//

import SwiftUI

@main
struct MuseApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var musicManager: MusicManager = .shared
    @StateObject private var musicCatalog: MusicCatalog = .init()
    @StateObject private var musicPlayer: MusicPlayer = .init()
    @StateObject private var router: Router = .init()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .zIndex(0)
                
                Group {
                    if self.musicManager.authorization.status != .authorized {
                        self.prompt {
                            MusicAuthorizationPrompt()
                        }
                    } else if self.musicManager.subscription.needsOffer {
                        self.prompt {
                            MusicSubscriptionPrompt()
                        }
                    }
                }
                .zIndex(1)
            }
            .transition(.opacity)
            .animation(.easeIn(duration: 0.2), value: self.musicManager.authorization.status)
            .animation(.easeIn(duration: 0.2), value: self.musicManager.subscription.needsOffer)
        }
        .environmentObject(self.musicManager)
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
    
    private func prompt<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
                .background(.ultraThinMaterial)
            
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
