//
//  SidebarItem.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 20.12.2023.
//

import SwiftUI

enum SidebarItem: Hashable, Identifiable, CaseIterable {
    case home
    case search
    case library
    
    var id: Int {
        return self.hashValue
    }
    
    /// Title of an item
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .library:
            return "Library"
        }
    }
    
    /// System icon name of an item
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .library:
            return "play.square.stack"
        }
    }
    
    /// Content that should be presented for the item
    @ViewBuilder
    var content: some View {
        switch self {
        case .home:
            HomeView()
        case .search:
            SearchView()
        case .library:
            LibraryView()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
        hasher.combine(self.iconName)
    }
}
