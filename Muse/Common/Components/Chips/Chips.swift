//
//  Chips.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 26.02.2024.
//

import SwiftUI

struct Chips<Value: Hashable>: View {
    struct Item: Hashable {
        let title: String
        let value: Value
    }
    
    private let items: [Item]
    
    @Binding private var selection: Value
    
    init(items: [Item], selection: Binding<Value>) {
        self.items = items
        self._selection = selection
    }
    
    var body: some View {
        HStack(spacing: 8.0) {
            ForEach(self.items, id: \.self) { item in
                Text(item.title)
                    .font(.system(size: 14.0, weight: .semibold))
                    .foregroundStyle(Color.pinkAccent)
                    .padding(.vertical, 8.0)
                    .padding(.horizontal, 16.0)
                    .background(item.value == self.selection ? Color.pinkAccent.opacity(0.1) : Color.quinaryFill)
                    .clipShape(.rect(cornerRadius: 12.0))
                    .border(style: .quinaryFill, cornerRadius: 12.0)
                    .onTapGesture {
                        self.selection = item.value
                    }
            }
        }
    }
}
