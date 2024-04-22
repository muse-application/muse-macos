//
//  ShuffleMode + Toggle.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 20.02.2024.
//

import MusicKit

extension MusicPlayer.ShuffleMode {
    mutating func toggle() {
        switch self {
        case .off:
            self = .songs
        case .songs:
            self = .off
        @unknown default:
            break
        }
    }
}
