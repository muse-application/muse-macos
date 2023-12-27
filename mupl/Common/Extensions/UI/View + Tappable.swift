//
//  View + Tappable.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 30.12.2023.
//

import SwiftUI

struct TappableViewModifier: ViewModifier {
    struct HoverStyle {
        struct Padding {
            let vertical: CGFloat
            let horizontal: CGFloat
            
            init(vertical: CGFloat = .s2, horizontal: CGFloat = .s2) {
                self.vertical = vertical
                self.horizontal = horizontal
            }
        }
        
        struct ColorSet {
            let idle: Color
            let hovered: Color
            
            init(idle: Color = .clear, hovered: Color = .quinaryFill) {
                self.idle = idle
                self.hovered = hovered
            }
        }
        
        let padding: Padding
        let cornerRadius: CGFloat
        let colorSet: ColorSet
        
        init(padding: Padding = .init(), cornerRadius: CGFloat = .s2, colorSet: ColorSet = .init()) {
            self.padding = padding
            self.cornerRadius = cornerRadius
            self.colorSet = colorSet
        }
    }
    
    private let hoverStyle: HoverStyle
    private let action: () -> Void
    
    @State private var isHovered: Bool = false
    
    init(hoverStyle: HoverStyle? = nil, action: @escaping () -> Void) {
        self.hoverStyle = hoverStyle ?? .init()
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, self.hoverStyle.padding.vertical)
            .padding(.horizontal, self.hoverStyle.padding.horizontal)
            .background(self.isHovered ? self.hoverStyle.colorSet.hovered : self.hoverStyle.colorSet.idle)
            .clipShape(.rect(cornerRadius: self.hoverStyle.cornerRadius))
            .contentShape(Rectangle())
            .onTapGesture(perform: self.action)
            .onHover { hovering in
                withAnimation {
                    self.isHovered = hovering
                }
            }
    }
}

extension View {
    func tappable(hoverStyle: TappableViewModifier.HoverStyle? = nil, action: @escaping () -> Void) -> some View {
        self.modifier(TappableViewModifier(hoverStyle: hoverStyle, action: action))
    }
}
