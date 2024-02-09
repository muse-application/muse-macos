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
    
    @Environment(\.sidebarWidth) private var sidebarWidth
    @Environment(\.playbarHeight) private var playbarHeight
    
    @State private var selectedItem: SidebarItem = .home
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                ZStack(alignment: .bottom) {
                    NavigationStack {
                        selectedItem.content
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .padding(.leading, self.sidebarWidth + 24.0)
                    .padding(.bottom, self.playbarHeight + 24.0)
                    
                    Playbar()
                        .padding(.horizontal, 24.0)
                        .padding(.bottom, 24.0)
                }
                
                Sidebar(sections: self.sidebarSections, selectedItem: self.$selectedItem)
                    .padding(.top, 24.0)
                    .padding(.leading, 24.0)
                    .padding(.bottom, self.playbarHeight + 24.0 + 24.0)
            }
            .frame(minWidth: 1080.0, maxWidth: 1080.0, alignment: .top)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 600.0)
    }
}
