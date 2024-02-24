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
                VStack {
                    
                }
                .frame(width: 256.0, alignment: .leading)
                .frame(maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 12.0))
                .border(style: .quinaryFill, cornerRadius: 12.0)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.easeIn, value: self.isPresented)
    }
}
