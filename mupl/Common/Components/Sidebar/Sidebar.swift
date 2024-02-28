//
//  Sidebar.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 20.12.2023.
//

import SwiftUI

struct Sidebar: View {
    static let width: CGFloat = 48.0
    
    private let sections: [SidebarSection]
    
    @Binding private var selectedItem: SidebarItem
    
    init(sections: [SidebarSection], selectedItem: Binding<SidebarItem>) {
        self.sections = sections
        self._selectedItem = selectedItem
    }
    
    var body: some View {
        VStack(spacing: 24.0) {
            Image("Common/Logo")
                .resizable()
                .frame(width: 32.0, height: 32.0)
                .clipShape(.rect(cornerRadius: 8.0))
            
            VStack(spacing: 24.0) {
                ForEach(self.sections) { section in
                    VStack(spacing: 4.0) {
                        ForEach(section.items) { item in
                            Image(systemName: item.iconName)
                                .font(.system(size: 18.0))
                                .frame(width: 20.0, height: 20.0)
                                .foregroundStyle(self.selectedItem == item ? Color.pinkAccent : Color.secondaryText)
                                .tappable {
                                    self.selectedItem = item
                                }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 16.0)
        .frame(width: Self.width)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 12.0))
        .border(style: .quinaryFill, cornerRadius: 12.0)
    }
}
