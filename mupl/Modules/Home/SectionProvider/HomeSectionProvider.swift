//
//  HomeSectionProvider.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import SwiftUI

struct HomeSectionProvider: SectionProvider {
    let recommendations: RecommendationsSection = .init()
    
    func section<Section: ProvidableSection>(for keyPath: KeyPath<HomeSectionProvider, Section>, value: Section.Value) -> Section.Content {
        return self[keyPath: keyPath].section(with: value)
    }
    
    func skeleton<Section: ProvidableSection>(for keyPath: KeyPath<HomeSectionProvider, Section>) -> Section.SkeletonContent {
        return self[keyPath: keyPath].skeleton()
    }
}
