//
//  MusicAuthorizationManager.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 10.03.2024.
//

import SwiftUI
import MusicKit

extension MusicManager {
    @MainActor
    final class Authorization: ObservableObject {
        @Published var status: MusicAuthorization.Status
        
        init() {
            self.status = MusicAuthorization.currentStatus
        }
        
        func requestIfNeeded() async {
            guard self.status != .authorized else { return }
            self.status = await MusicAuthorization.request()
        }
    }
}
