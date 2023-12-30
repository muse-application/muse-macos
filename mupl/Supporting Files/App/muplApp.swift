//
//  muplApp.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 07.12.2023.
//

import SwiftUI

@main
struct muplApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    minWidth: 1024.0,
                    idealWidth: 1024.0,
                    minHeight: 600.0,
                    idealHeight: 600.0
                )
        }
        .windowToolbarStyle(.unified(showsTitle: false))
    }
}
