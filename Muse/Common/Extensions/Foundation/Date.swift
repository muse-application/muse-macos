//
//  Date.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 14.01.2024.
//

import Foundation

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
