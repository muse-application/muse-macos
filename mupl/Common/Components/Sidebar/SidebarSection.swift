//
//  SidebarSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.12.2023.
//

import Foundation

struct SidebarSection: Hashable, Identifiable {
    let title: String?
    let items: [SidebarItem]
    
    var id: Int {
        return self.hashValue
    }
    
    init(title: String? = nil, items: [SidebarItem]) {
        self.title = title
        self.items = items
    }
    
    static func == (lhs: SidebarSection, rhs: SidebarSection) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
