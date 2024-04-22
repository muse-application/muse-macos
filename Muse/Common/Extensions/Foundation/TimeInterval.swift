//
//  TimeInterval.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import Foundation

extension TimeInterval {
    private var base: TimeInterval {
        // Very hacky (!) test if given value is in
        // seconds or milliseconds. Did this test
        // because for some reason MusicKit sets
        // duration in milliseconds for tracks in library
        // while tracks in other parts have duration
        // represented in seconds.
        return self > 10_000 ? self / 1000 : self
    }
    
    var minutes: String {
        return "\(Int(self.base / 60.0))"
    }
    
    var minutesAndSeconds: String {
        let minutes: Int = Int(self.base / 60.0)
        let seconds: Int = Int(self.base.truncatingRemainder(dividingBy: 60.0))
        
        return "\(minutes):\(String(format: "%02d", seconds))"
    }
}
