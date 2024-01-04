//
//  NetworkError.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

final class NetworkError: AppError {
    static let invalidURL: NetworkError = .init(title: "", description: "")
    static let failedMultipartBodyCreation: NetworkError = .init(title: "", description: "")
}
