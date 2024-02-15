//
//  View + IfCondition.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 29.12.2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, updated: (Self) -> Content) -> some View {
        if condition {
            updated(self)
        } else {
            self
        }
    }
}
