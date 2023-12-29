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
            items: [.home, .library]
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
                .toolbar(removing: .sidebarToggle)
            } detail: {
                if let selectedItem = selectedItem {
                    selectedItem.content
                }
            }
            .searchable(text: .constant(""), placement: .toolbar)
            
            Playbar()
        }
    }
}

#Preview {
    ContentView()
}
