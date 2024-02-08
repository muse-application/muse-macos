//
//  EnvironmentValues.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 29.01.2024.
//

import SwiftUI

// MARK: - Keys

private struct PlaybarHeightKey: EnvironmentKey {
    static var defaultValue: CGFloat = 70.0
}

// MARK: - EnvironmentValues

extension EnvironmentValues {
    var playbarHeight: CGFloat {
        get { self[PlaybarHeightKey.self] }
        set { self[PlaybarHeightKey.self] = newValue }
    }
}
