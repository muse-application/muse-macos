//
//  DefaultNetworkSession.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

final class DefaultNetworkSession: NetworkSession {
    private typealias Response = (data: Data, httpResponse: HTTPURLResponse)
    
    func request<T: Endpoint, Object: Decodable>(endpoint: T, as type: Object.Type) async throws -> NetworkData<Object> {
        let (data, response) = try await self.requestData(for: endpoint)
        let decodedData = try data.decoded(as: type)
        
        return .init(
            statusCode: response.statusCode,
            requestURL: endpoint.url,
            responseContent: decodedData
        )
    }
    
    private func requestData<T: Endpoint>(for endpoint: T) async throws -> Response {
        let urlRequest = try endpoint.urlRequest
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw AppError.internal }
        
        return (data, httpResponse)
    }
}

extension NetworkSession where Self == DefaultNetworkSession {
    static var `default`: DefaultNetworkSession {
        return .init()
    }
}
