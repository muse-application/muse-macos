//
//  DefaultNetworkSession.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

final class DefaultNetworkSession: NetworkSession {
    private typealias Response = (data: Data, httpResponse: HTTPURLResponse)
    
    func request(endpoint: Endpoint) async throws -> NetworkData<Data> {
        let (data, response) = try await self.requestData(for: endpoint)
        
        return .init(
            statusCode: response.statusCode,
            requestURL: endpoint.url,
            responseContent: data
        )
    }
    
    func request<Object: Decodable>(endpoint: Endpoint, as type: Object.Type) async throws -> NetworkData<Object> {
        let (data, response) = try await self.requestData(for: endpoint)
        let decodedData = try data.decoded(as: type)
        
        return .init(
            statusCode: response.statusCode,
            requestURL: endpoint.url,
            responseContent: decodedData
        )
    }
    
    func upload(to endpoint: Endpoint, payload: NetworkUploadPayload) async throws -> NetworkData<Data> {
        let mutated = endpoint.adding(body: try self.createMultipartBody(for: payload))
        return try await self.request(endpoint: mutated)
    }
    
    func upload<Object: Decodable>(to endpoint: Endpoint, payload: NetworkUploadPayload, responseType: Object.Type) async throws -> NetworkData<Object> {
        let mutated = endpoint.adding(body: try self.createMultipartBody(for: payload))
        return try await self.request(endpoint: mutated, as: responseType)
    }
    
    private func requestData(for endpoint: Endpoint) async throws -> Response {
        let urlRequest = try endpoint.urlRequest
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw AppError.internal }
        
        return (data, httpResponse)
    }
    
    private func createMultipartBody(for payload: NetworkUploadPayload) throws -> Data {
        let uuid: String = UUID().uuidString
        let boundaryPrefix = "--\(uuid)\r\n"
        let contentDisposition = "Content-Disposition: form-data; name=\"file\"; filename=\"\(payload.filename)\"\r\n"
        let contentType = "Content-Type: \(payload.mimeType.rawValue)\r\n\r\n"
        
        var body: Data = Data()
        
        guard
            body.append(string: boundaryPrefix),
            body.append(string: contentDisposition),
            body.append(string: contentType)
        else {
            throw NetworkError.failedMultipartBodyCreation
        }
        
        body.append(payload.data)
        
        guard
            body.append(string: "\r\n"),
            body.append(string: "--\(uuid)--")
        else {
            throw NetworkError.failedMultipartBodyCreation
        }
        
        return body
    }
}

extension NetworkSession where Self == DefaultNetworkSession {
    static var `default`: DefaultNetworkSession {
        return .init()
    }
}
