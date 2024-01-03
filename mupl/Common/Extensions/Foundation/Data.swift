//
//  Data.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

extension Data {
    func decoded<T: Decodable>(as type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(type, from: self)
    }
    
    @discardableResult
    mutating func append(string: String) -> Bool {
        guard let data = string.data(using: .utf8) else { return false }
        
        self.append(data)
        return true
    }
}
