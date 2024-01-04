//
//  Sidebar.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 20.12.2023.
//

import SwiftUI

struct Sidebar: View {
    private let sections: [SidebarSection]
    
    @Binding private var selectedItem: SidebarItem
    
    init(sections: [SidebarSection], selectedItem: Binding<SidebarItem>) {
        self.sections = sections
        self._selectedItem = selectedItem
    }
    
    var body: some View {
        List(selection: self.$selectedItem) {
            ForEach(self.sections) { section in
                self.section(section) {
                    ForEach(section.items) { item in
                        NavigationLink(value: item) {
                            Label(item.title, systemImage: item.iconName)
                        }
                    }
                    .padding(.leading, section.title == nil ? .zero : .s1)
                }
            }
        }
    }
    
    @ViewBuilder
    private func section<Content: View>(_ section: SidebarSection, @ViewBuilder content: @escaping () -> Content) -> some View {
        if let title = section.title {
            Section(title, content: content)
        } else {
            Section(content: content)
        }
    }
}
