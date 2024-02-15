//
//  TimeInterval.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import Foundation

extension TimeInterval {
    var minutes: String {
        return "\(Int(self / 60.0))"
    }
    
    var minutesAndSeconds: String {
        let minutes: Int = Int(self / 60.0)
        let seconds: String = .init(format: "%02d", Int(self) - minutes * 60)
        
        return "\(minutes):\(seconds)"
    }
}
