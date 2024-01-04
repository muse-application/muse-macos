//
//  Skeletonable.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import SwiftUI

protocol Skeletonable {
    associatedtype Skeleton: View
    
    @ViewBuilder
    var skeleton: Skeleton { get }
}
