//
//  Bundle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.02.2024.
//

import Foundation

extension Bundle {
    var versionNumber: String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
}
