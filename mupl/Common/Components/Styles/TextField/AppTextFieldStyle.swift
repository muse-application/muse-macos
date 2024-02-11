//
//  AppTextFieldStyle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI

struct AppTextFieldStyle: TextFieldStyle {
    private let icon: String?
    
    @FocusState private var isFocused: Bool
    
    init(icon: String?) {
        self.icon = icon
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if let icon = self.icon {
                Image(systemName: icon)
                    .foregroundStyle(self.isFocused ? Color.pinkAccent : Color.secondaryText)
            }
            
            configuration
                .textFieldStyle(.plain)
                .focused(self.$isFocused)
        }
        .padding(.vertical, 12.0)
        .padding(.horizontal, 12.0)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 8.0))
        .border(style: self.isFocused ? .pinkAccent : .quinaryFill, cornerRadius: 8.0)
    }
}

extension TextFieldStyle where Self == AppTextFieldStyle {
    static func app(icon: String? = nil) -> AppTextFieldStyle {
        return .init(icon: icon)
    }
}
