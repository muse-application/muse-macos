//
//  MusicAuthenticator.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import SwiftUI
import MusicKit

@MainActor
final class MusicAuthenticator: ObservableObject {
    @Published var status: MusicAuthorization.Status
    @Published var subscriptionStatus: MusicSubscription?
    
    init() {
        self.status = MusicAuthorization.currentStatus
        self.startSubscriptionObservation()
    }
    
    func requestIfNeeded() async {
        guard self.status != .authorized else { return }
        self.status = await MusicAuthorization.request()
    }
    
    private func startSubscriptionObservation() {
        Task {
            for await subscription in MusicSubscription.subscriptionUpdates {
                self.subscriptionStatus = subscription
            }
        }
    }
}
