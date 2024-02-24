//
//  HomeSectionProvider.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 05.01.2024.
//

import SwiftUI

struct HomeSectionProvider: SectionProvider {
    let recommendations: RecommendationsSection = .init()
    let charts: ChartsSection = .init()
}
