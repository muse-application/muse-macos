//
//  NetworkMIMEType.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation

enum NetworkMIMEType {
    case json
    case formData(boundary: String)
    case image
    
    var rawValue: String {
        switch self {
        case .json:
            return "application/json"
        case .formData(let boundary):
            return "multipart/form-data; boundary=\(boundary)"
        case .image:
            return "image/jpeg, image/jpg, image/png"
        }
    }
}
