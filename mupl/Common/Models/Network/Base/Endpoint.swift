//
//  Endpoint.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

struct Endpoint {
    let url: String
    let httpMethod: NetworkHTTPMethod
    let contentType: NetworkMIMEType
    let acceptType: NetworkMIMEType
    
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
        httpMethod: NetworkHTTPMethod = .get,
        contentType: NetworkMIMEType = .json,
        acceptType: NetworkMIMEType = .json
    ) {
        self.url = url
        self.httpMethod = httpMethod
        self.contentType = contentType
        self.acceptType = acceptType
    }
    
    @discardableResult
    func adding<T: Encodable>(body: T) -> Self {
        var _self = self
        _self.body = try? body.data
        return _self
    }
}
