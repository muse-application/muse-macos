//
//  RepeatMode + Next.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 20.02.2024.
//

import MusicKit

extension MusicPlayer.RepeatMode {
    mutating func next() {
        switch self {
        case .none:
            self = .one
        case .one:
            self = .all
        case .all:
            self = .none
        @unknown default:
            break
        }
    }
}
