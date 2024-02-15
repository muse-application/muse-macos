//
//  HoverableSystemButtonStyle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import SwiftUI

struct HoverableSystemButtonStyle: ButtonStyle {
    struct Style {
        let idleColors: (foreground: Color, background: Color)
        let hoveredColors: (foreground: Color, background: Color)
    }
    
    private let style: Style
    
    @State private var isHovered: Bool = false
    
    init(style: Style) {
        self.style = style
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(
                self.isHovered ? self.style.idleColors.background : self.style.hoveredColors.background,
                self.isHovered ? self.style.idleColors.foreground : self.style.hoveredColors.foreground
            )
            .onHover { hovering in
                self.isHovered = hovering
            }
    }
}

extension ButtonStyle where Self == HoverableSystemButtonStyle {
    static func systemHoverable(
        style: HoverableSystemButtonStyle.Style = .init(
            idleColors: (.white, .pinkAccent),
            hoveredColors: (.pinkAccent, .white)
        )
    ) -> HoverableSystemButtonStyle {
        return .init(style: style)
    }
}
