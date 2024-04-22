//
//  View + Size.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

extension View {
    func readSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        self
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometry.size)
                }
            }
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
