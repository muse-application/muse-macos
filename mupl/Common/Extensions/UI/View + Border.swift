//
//  View + Stroke.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 20.12.2023.
//

import SwiftUI

extension View {
    func border(style: Color, width: CGFloat = 1.0, cornerRadius: CGFloat = 0.0) -> some View {
        self
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(style, lineWidth: width)
            }
    }
}
