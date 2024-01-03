//
//  Data.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

extension Data {
    public func decoded<T: Decodable>(as type: T.Type) throws -> T {
        return try JSONDecoder().decode(type, from: self)
    }
}
