//
//  AppUpdater.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 18.04.2024.
//

import Foundation
import Sparkle
import Combine

final class AppUpdater: ObservableObject {
    static let shared: AppUpdater = .init()
    
    @Published var canCheckForUpdates: Bool = false
    
    private let updater: SPUUpdater
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    private init() {
        self.updater = SPUStandardUpdaterController(
            startingUpdater: true,
            updaterDelegate: nil,
            userDriverDelegate: nil
        ).updater
        
        self.updater
            .publisher(for: \.canCheckForUpdates)
            .assign(to: &self.$canCheckForUpdates)
    }
    
    func checkForUpdates() {
        guard self.canCheckForUpdates else { return }
        self.updater.checkForUpdates()
    }
}
