//
//  AppDelegate.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.02.2024.
//

import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var appInfoWindow: NSWindowController?
    
    func showAppInfo() {
        if self.appInfoWindow == nil {
            let window = NSWindow()
            
            window.styleMask = [.closable, .miniaturizable, .titled]
            window.title = "About \(Bundle.main.appName)"
            window.contentView = NSHostingView(rootView: AppInfoView())
            window.center()
            
            self.appInfoWindow = NSWindowController(window: window)
        }
        
        self.appInfoWindow?.showWindow(self.appInfoWindow?.window)
    }
}
