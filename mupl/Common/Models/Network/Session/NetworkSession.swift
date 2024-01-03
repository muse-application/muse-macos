//
//  NetworkSession.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

protocol NetworkSession {
    func request<T: Endpoint>(endpoint: T) async throws -> NetworkData<Data>
    func request<T: Endpoint, Object: Decodable>(endpoint: T, as type: Object.Type) async throws -> NetworkData<Object>
}
