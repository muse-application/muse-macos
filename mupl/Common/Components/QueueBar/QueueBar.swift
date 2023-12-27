//
//  QueueBar.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 31.12.2023.
//

import SwiftUI

struct QueueBar: View {
    @Binding private var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        ZStack {
            if self.isPresented {
                HStack(spacing: 0.0) {
                    Divider()
                }
                .frame(width: 256.0, alignment: .leading)
                .frame(maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeIn, value: self.isPresented)
    }
}
