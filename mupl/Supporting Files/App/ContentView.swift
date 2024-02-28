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
    
    @EnvironmentObject private var router: Router
    
    @State private var selectedItem: SidebarItem = .home
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                ZStack(alignment: .bottom) {
                    selectedItem.content
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                        .padding(.leading, Sidebar.width + 24.0)
                        .padding(.bottom, Playbar.height + AppInfoBar.height + 16.0 + 24.0)
                    
                    VStack(spacing: 16.0) {
                        Playbar()
                        AppInfoBar()
                    }
                    .padding(.horizontal, 24.0)
                    .padding(.bottom, 24.0)
                }
                
                Sidebar(sections: self.sidebarSections, selectedItem: self.$selectedItem)
                    .padding(.top, 24.0)
                    .padding(.leading, 24.0)
                    .padding(.bottom, Playbar.height + AppInfoBar.height + 16.0 + 24.0 + 24.0)
            }
            .frame(minWidth: 1080.0, maxWidth: 1080.0, alignment: .top)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 600.0)
        .toolbar {
            // Empty item to prevent window from jumping
            // when navigation bar back appears.
            ToolbarItem(placement: .principal) {
                Color.clear
            }
        }
        .onAppear {
            self.router.selectedItem = .home
        }
        .onChange(of: self.selectedItem) { _, newValue in
            self.router.selectedItem = newValue
        }
    }
}
