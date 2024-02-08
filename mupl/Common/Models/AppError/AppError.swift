//
//  AppError.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

class AppError: Error, Hashable, Identifiable {
    let title: String
    let description: String
    
    var id: Int {
        return self.hashValue
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
        hasher.combine(self.description)
    }
}

// MARK: - Default Errors

extension AppError {
    static let `internal`: AppError = .init(title: "Internal Error", description: "An internal error occured. We're on it and will have things back to normal soon.")
    static let unknown: AppError = .init(title: "Unexpected Error", description: "Something went wrong. Please try again later.")
}
