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
    
    @EnvironmentObject private var musicAuthenticator: MusicAuthenticator
    
    @State private var selectedItem: SidebarItem = .home
    @State private var isSongQueuePresented: Bool = false
    @State private var navigationDetailPath: NavigationPath = .init()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationSplitView {
                Sidebar(
                    sections: self.sidebarSections,
                    selectedItem: self.$selectedItem
                )
                .toolbar(removing: .sidebarToggle)
                .navigationSplitViewColumnWidth(200.0)
            } detail: {
                self.detailContent
            }
            .searchable(text: .constant(""), placement: .sidebar)
            .toolbar {
                self.toolbarContent
            }
            
            Playbar()
        }
    }
    
    // MARK: - Components
    
    private var detailContent: some View {
        ZStack(alignment: .topTrailing) {
            NavigationStack {
                selectedItem.content
                    .frame(
                        minWidth: 512.0,
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
            }
            
            QueueBar(isPresented: self.$isSongQueuePresented)
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button {
                
            } label: {
                Image(systemName: "person.crop.circle")
            }
        }
        
        ToolbarItem(placement: .principal) {
            Spacer()
        }
        
        ToolbarItem(placement: .primaryAction) {
            Toggle(isOn: self.$isSongQueuePresented) {
                Image(systemName: "list.bullet")
            }
            .toggleStyle(.button)
        }
    }
}

#Preview {
    ContentView()
}
