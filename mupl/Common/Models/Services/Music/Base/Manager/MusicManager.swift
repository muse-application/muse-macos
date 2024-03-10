//
//  MusicAuthenticator.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import SwiftUI
import MusicKit

@MainActor
final class MusicManager: ObservableObject {
    @Published var authorization: Authorization = .init()
    @Published var subscription: Subscription = .init()
}
g
