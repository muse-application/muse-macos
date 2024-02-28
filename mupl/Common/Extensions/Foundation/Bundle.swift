//
//  Bundle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 27.02.2024.
//

import Foundation

extension Bundle {
    var appName: String {
        return (infoDictionary?["CFBundleName"] as? String) ?? ""
    }
    
    var versionNumber: String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
}
