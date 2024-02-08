//
//  AppButtonStyle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 08.02.2024.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    enum Emphasis {
        case primary
        case secondary
        
        var foregroundColor: Color {
            switch self {
            case .primary:
                return .white
            case .secondary:
                return .pinkAccent
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .primary:
                return .pinkAccent
            case .secondary:
                return .pinkAccent.opacity(0.25)
            }
        }
    }
    
    private let emphasis: Emphasis
    
    init(emphasis: Emphasis) {
        self.emphasis = emphasis
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14.0, weight: .bold))
            .foregroundStyle(self.emphasis.foregroundColor)
            .padding(.vertical, 12.0)
            .background(self.emphasis.backgroundColor)
            .clipShape(.rect(cornerRadius: 8.0))
    }
}

extension ButtonStyle where Self == AppButtonStyle {
    static func app(_ emphasis: AppButtonStyle.Emphasis) -> AppButtonStyle {
        return .init(emphasis: emphasis)
    }
}
