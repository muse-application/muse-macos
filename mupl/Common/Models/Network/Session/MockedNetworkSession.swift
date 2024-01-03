//
//  MockedNetworkSession.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

fileprivate final class Mocker {
    final class Error: AppError {
        static let mockNotFound: Error = .init(title: "", description: "")
    }
    
    struct Mock<Object: Decodable>: Decodable {
        struct Meta: Decodable {
            let statusCode: Int
            let responseDelay: Double?
        }
        
        let meta: Meta
        let data: Object
    }
    
    static let shared: Mocker = .init()
    
    private var mocks: [String: String] = .init()
    
    private init() { }
    
    func add(mock: String, for url: String) {
        self.mocks[url] = mock
    }
    
    func getMock<Object: Decodable>(of url: String, as type: Object.Type) throws -> Mock<Object> {
        guard
            let mock = self.mocks[url],
            let filePath = Bundle.main.path(forResource: mock, ofType: "json")
        else {
            throw Error.mockNotFound
        }
        
        return try Data(contentsOf: .init(filePath: filePath)).decoded(as: Mock<Object>.self)
    }
}

final class MockedNetworkSession: NetworkSession {
    func request(endpoint: Endpoint) async throws -> NetworkData<Data> {
        let mockResponse = try Mocker.shared.getMock(of: endpoint.url, as: Data.self)
        
        try await self.delay(for: mockResponse.meta.responseDelay ?? 0.0)
        
        return .init(
            statusCode: mockResponse.meta.statusCode,
            requestURL: endpoint.url,
            responseContent: mockResponse.data
        )
    }
    
    func request<Object: Decodable>(endpoint: Endpoint, as type: Object.Type) async throws -> NetworkData<Object> {
        let mockResponse = try Mocker.shared.getMock(of: endpoint.url, as: type)
        
        try await self.delay(for: mockResponse.meta.responseDelay ?? 0.0)
        
        return .init(
            statusCode: mockResponse.meta.statusCode,
            requestURL: endpoint.url,
            responseContent: mockResponse.data
        )
    }
    
    func upload(to endpoint: Endpoint, payload: NetworkUploadPayload) async throws -> NetworkData<Data> {
        return try await self.request(endpoint: endpoint)
    }
    
    func upload<Object: Decodable>(to endpoint: Endpoint, payload: NetworkUploadPayload, responseType: Object.Type) async throws -> NetworkData<Object> {
        return try await self.request(endpoint: endpoint, as: responseType)
    }
    
    private func delay(for time: Double) async throws {
        try await Task.sleep(nanoseconds: UInt64(time * 1_000_000_000))
    }
}

extension NetworkSession where Self == MockedNetworkSession {
    static var mock: MockedNetworkSession {
        return .init()
    }
}

extension Endpoint {
    @discardableResult
    func adding(mock fileName: String, rawURL: String? = nil) -> Self {
        Mocker.shared.add(mock: fileName, for: rawURL ?? self.url)
        return self
    }
}
