//
//  NetworkData.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 03.01.2024.
//

import Foundation

struct NetworkData<Content: Decodable> {
    let statusCode: Int
    let requestURL: String?
    let responseContent: Content
}
