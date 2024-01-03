//
//  NetworkMockExample.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

struct NetworkMockExampleObject: Decodable {
    struct Object: Decodable {
        let title: String
        let description: String
    }
    
    let string: String
    let number: Int
    let object: Object
}

final class NetworkMockExampleEndpoint: Endpoint {
    static let list: NetworkMockExampleEndpoint = .init(url: "example.com/list")
        .adding(mock: "network-mock-example-list")
    
    static func object(id: Int) -> NetworkMockExampleEndpoint {
        return .init(url: "example.com/object/\(id)")
            .adding(mock: "network-mock-example-object", rawURL: "example.com/object/{id}")
    }
}
