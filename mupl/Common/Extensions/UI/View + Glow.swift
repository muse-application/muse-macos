//
//  View + Glow.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 08.02.2024.
//

import SwiftUI

struct GlowViewModifier: ViewModifier {
    struct Configuration {
        let color: Color
        let radius: CGFloat
        let duration: TimeInterval
    }
    
    private let configuration: Configuration
    
    @State private var isAppeared: Bool = false
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func body(content: Content) -> some View {
        content
            .shadow(
                color: self.configuration.color.opacity(self.isAppeared ? 0.8 : 0.0),
                radius: self.configuration.radius
            )
            .animation(.easeIn(duration: self.configuration.duration).repeatForever(), value: self.isAppeared)
            .onAppear {
                self.isAppeared = true
            }
    }
}

extension View {
    func glow(using configuration: GlowViewModifier.Configuration) -> some View {
        self.modifier(GlowViewModifier(configuration: configuration))
    }
}
