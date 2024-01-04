//
//  NetworkSession.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

protocol NetworkSession {
    func request(endpoint: Endpoint) async throws -> NetworkData<Data>
    func request<Object: Decodable>(endpoint: Endpoint, as type: Object.Type) async throws -> NetworkData<Object>
    func upload(to endpoint: Endpoint, payload: NetworkUploadPayload) async throws -> NetworkData<Data>
    func upload<Object: Decodable>(to endpoint: Endpoint, payload: NetworkUploadPayload, responseType: Object.Type) async throws -> NetworkData<Object>
}
