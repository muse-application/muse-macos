//
//  Endpoint.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

class Endpoint {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    enum MediaType: String {
        case json = "application/json"
        case formData = "multipart/form-data"
        case image = "image/jpeg, image/jpg, image/png"
    }
    
    let url: String
    let httpMethod: HTTPMethod
    let contentType: MediaType
    let acceptType: MediaType
    
    var body: Data?
    
    var urlRequest: URLRequest {
        get throws {
            guard let url = URL(string: self.url) else { throw NetworkError.invalidURL }
            
            var urlRequest: URLRequest = .init(url: url)
            
            urlRequest.httpMethod = self.httpMethod.rawValue
            urlRequest.httpBody = self.body
            
            urlRequest.setValue(self.contentType.rawValue, forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(self.acceptType.rawValue, forHTTPHeaderField: "Accept")
            
            return urlRequest
        }
    }
    
    init(
        url: String,
        httpMethod: HTTPMethod = .get,
        contentType: MediaType = .json,
        acceptType: MediaType = .json
    ) {
        self.url = url
        self.httpMethod = httpMethod
        self.contentType = contentType
        self.acceptType = acceptType
    }
    
    func adding<T: Encodable>(body: T) -> Self {
        self.body = try? body.data
        return self
    }
}
