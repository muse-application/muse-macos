//
//  SidebarItem.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 20.12.2023.
//

import SwiftUI

enum SidebarItem: Hashable, Identifiable {
    case home
    case library
    
    var id: Int {
        return self.hashValue
    }
    
    /// Title of an item
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .library:
            return "Library"
        }
    }
    
    /// System icon name of an item
    var iconName: String {
        switch self {
        case .home:
            return "house"
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
        case .library:
            LibraryView()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
        hasher.combine(self.iconName)
    }
}
