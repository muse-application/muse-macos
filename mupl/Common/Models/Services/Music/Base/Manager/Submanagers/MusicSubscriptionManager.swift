//
//  MusicSubscriptionManager.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.03.2024.
//

import SwiftUI
import MusicKit

extension MusicManager {
    @MainActor
    final class Subscription: ObservableObject {
        @Published var status: MusicSubscription?
        @Published var needsOffer: Bool = false
        
        var canOffer: Bool {
            return self.status?.canBecomeSubscriber ?? false
        }
        
        init() {
            self.startObservation()
        }
        
        func offer() {
            guard self.canOffer else { return }
            self.needsOffer = true
        }
        
        private func startObservation() {
            Task {
                for await subscription in MusicSubscription.subscriptionUpdates {
                    self.status = subscription
                    self.needsOffer = subscription.canBecomeSubscriber
                }
            }
        }
    }
}
