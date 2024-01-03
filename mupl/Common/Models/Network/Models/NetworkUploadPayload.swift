//
//  NetworkUploadPayload.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation

struct NetworkUploadPayload {
    let filename: String
    let mimeType: NetworkMIMEType
    let data: Data
}
