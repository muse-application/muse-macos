//
//  MusicAuthenticator.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import SwiftUI
import MusicKit
import Combine

@MainActor
final class MusicManager: ObservableObject {
    static let shared: MusicManager = .init()
    
    @Published var authorization: Authorization = .init()
    @Published var subscription: Subscription = .init()
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    private init() {
        self.authorization.objectWillChange
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &self.cancellables)
        
        self.subscription.objectWillChange
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &self.cancellables)
    }
}
