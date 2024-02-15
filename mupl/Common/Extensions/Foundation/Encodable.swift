//
//  Encodable + Data.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

extension Encodable {
    var data: Data {
        get throws {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .withoutEscapingSlashes
            
            return try encoder.encode(self)
        }
    }
}
