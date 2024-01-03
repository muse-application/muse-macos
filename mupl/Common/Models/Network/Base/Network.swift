//
//  Network.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

final class Network {
    private let session: NetworkSession
    
    static let `default`: Network = .init(session: .default)
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func request<T: Endpoint>(endpoint: T) async throws -> NetworkData<Data> {
        return try await self.session.request(endpoint: endpoint, as: Data.self)
    }
    
    func request<T: Endpoint, Object: Decodable>(endpoint: T, as type: Object.Type) async throws -> NetworkData<Object> {
        return try await self.session.request(endpoint: endpoint, as: type)
    }
}
