//
//  SectionProvider.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import SwiftUI

protocol SectionProvider {
    func section<Section: ProvidableSection>(for keyPath: KeyPath<Self, Section>, value: Section.Value) -> Section.Content
    func skeleton<Section: ProvidableSection>(for keyPath: KeyPath<Self, Section>) -> Section.SkeletonContent
}
