//
//  NetworkMockExample.swift
//  Muse
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

final class NetworkMockExampleEndpointScope {
    static let list: Endpoint = .init(
        url: "example.com/list",
        httpMethod: .get,
        contentType: .json,
        acceptType: .json
    )
    .adding(mock: "network-mock-example-list")
    
    static func object(id: Int) -> Endpoint {
        return .init(
            url: "example.com/object/\(id)",
            httpMethod: .get,
            contentType: .json,
            acceptType: .json
        )
        .adding(mock: "network-mock-example-object", rawURL: "example.com/object/{id}")
    }
}
