//
//  MusicCatalog.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 04.01.2024.
//

import Foundation
import MusicKit

final class MusicCatalog: ObservableObject {
    let personal: Personal = .init()
    let charts: Charts = .init()
    let genres: Genres = .init()
    let search: Search = .init()
}
