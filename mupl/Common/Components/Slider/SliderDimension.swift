//
//  SliderDimension.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 29.12.2023.
//

import Foundation

extension Slider {
    enum Dimension {
        case constant(CGFloat)
        case flexible(min: CGFloat, ideal: CGFloat, max: CGFloat)
        
        var min: CGFloat {
            switch self {
            case .constant(let value):
                return value
            case .flexible(min: let value, ideal: _, max: _):
                return value
            }
        }
        
        var ideal: CGFloat {
            switch self {
            case .constant(let value):
                return value
            case .flexible(min: _, ideal: let value, max: _):
                return value
            }
        }
        
        var max: CGFloat {
            switch self {
            case .constant(let value):
                return value
            case .flexible(min: _, ideal: _, max: let value):
                return value
            }
        }
    }
}
