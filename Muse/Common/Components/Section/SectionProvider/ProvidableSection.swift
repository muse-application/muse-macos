//
//  ProvidableSection.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import SwiftUI

protocol ProvidableSection {
    associatedtype Value
    associatedtype Content: View
    associatedtype SkeletonContent: View
    
    @ViewBuilder
    func section(with value: Value) -> Content
    
    @ViewBuilder
    func skeleton() -> SkeletonContent
}
