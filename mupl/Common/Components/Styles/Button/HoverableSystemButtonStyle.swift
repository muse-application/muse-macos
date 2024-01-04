//
//  HoverableSystemButtonStyle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import SwiftUI

struct HoverableSystemButtonStyle: ButtonStyle {
    @State private var isHovered: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(
                self.isHovered ? Color.white : Color.pinkAccent,
                self.isHovered ? Color.pinkAccent : Color.white
            )
            .onHover { hovering in
                self.isHovered = hovering
            }
    }
}

extension ButtonStyle where Self == HoverableSystemButtonStyle {
    static var systemHoverable: HoverableSystemButtonStyle {
        return .init()
    }
}
