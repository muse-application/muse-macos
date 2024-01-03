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
    static let mock: Network = .init(session: .mock)
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func request(endpoint: Endpoint) async throws -> NetworkData<Data> {
        return try await self.session.request(endpoint: endpoint, as: Data.self)
    }
    
    func request<Object: Decodable>(endpoint: Endpoint, as type: Object.Type) async throws -> NetworkData<Object> {
        return try await self.session.request(endpoint: endpoint, as: type)
    }
    
    func upload(to endpoint: Endpoint, payload: NetworkUploadPayload) async throws -> NetworkData<Data> {
        return try await self.session.upload(to: endpoint, payload: payload)
    }
    
    func upload<Object: Decodable>(to endpoint: Endpoint, payload: NetworkUploadPayload, responseType: Object.Type) async throws -> NetworkData<Object> {
        return try await self.session.upload(to: endpoint, payload: payload, responseType: responseType)
    }
}
