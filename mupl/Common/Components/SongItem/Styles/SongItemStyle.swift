//
//  SongItemStyle.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 16.01.2024.
//

import SwiftUI
import MusicKit

struct SongItemContext {
    let isCurrent: Bool
    let isHovered: Bool
}

protocol SongItemStyle {
    associatedtype Content: View
    associatedtype Skeleton: View
    
    func content(for song: Song, context: SongItemContext) -> Content
    func skeleton() -> Skeleton
}
