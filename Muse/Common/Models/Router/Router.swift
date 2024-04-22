//
//  Router.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 18.02.2024.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var navigationPaths: [SidebarItem: NavigationPath]
    @Published var selectedItem: SidebarItem?
    
    init() {
        self.navigationPaths = [:]
        
        for item in SidebarItem.allCases {
            self.navigationPaths[item] = .init()
        }
    }
    
    func path(for item: SidebarItem) -> NavigationPath {
        return self.navigationPaths[item] ?? .init()
    }
    
    func bindablePath(for item: SidebarItem) -> Binding<NavigationPath> {
        return Binding<NavigationPath>(
            get: {
                return self.path(for: item)
            },
            set: { newValue in
                self.navigationPaths[item] = newValue
            }
        )
    }
    
    @MainActor
    func push(_ item: any Hashable) {
        guard let selectedItem = self.selectedItem else { return }
        self.navigationPaths[selectedItem]?.append(item)
    }
    
    @MainActor
    func pop() {
        guard let selectedItem = self.selectedItem else { return }
        self.navigationPaths[selectedItem]?.removeLast()
    }
}
