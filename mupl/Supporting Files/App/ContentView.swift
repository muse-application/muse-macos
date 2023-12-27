//
//  ContentView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 07.12.2023.
//

import SwiftUI

struct ContentView: View {
    private let sidebarSections: [SidebarSection] = [
        .init(
            items: [.home, .search, .library]
        )
    ]
    
    @State private var selectedItem: SidebarItem?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationSplitView {
                Sidebar(
                    sections: self.sidebarSections,
                    selectedItem: self.$selectedItem
                )
            } detail: {
                if let selectedItem = selectedItem {
                    selectedItem.content
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
