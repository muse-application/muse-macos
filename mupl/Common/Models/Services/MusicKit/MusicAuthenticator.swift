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
    @AppStorage("music.auth.status") var status: MusicAuthorization.Status = .notDetermined
    
    func requestIfNeeded() async {
        guard self.status != .authorized else { return }
        self.status = await MusicAuthorization.request()
    }
}
