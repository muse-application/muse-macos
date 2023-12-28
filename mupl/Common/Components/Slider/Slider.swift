//
//  Slider.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 28.12.2023.
//

import SwiftUI

struct Slider: View {
    private let width: Dimension
    private let height: Dimension
    
    @State private var percentage: CGFloat = .zero
    @State private var dragDiff: CGFloat = .zero
    @State private var currentSize: CGSize = .zero
    @State private var isHovered: Bool = false
    @State private var isDragging: Bool = false
    
    init(width: Dimension, height: Dimension = .constant(4.0)) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
            Color.secondary
                .clipShape(.rect(cornerRadius: self.currentSize.height / 2.0))
            
            Color.primary
                .frame(width: self.percentage * self.currentSize.width)
                .clipShape(.rect(cornerRadius: self.currentSize.height / 2.0))
        }
        .opacity(self.opacity())
        .frame(
            minWidth: self.width.min,
            idealWidth: self.width.ideal,
            maxWidth: self.width.max,
            minHeight: self.height.min,
            idealHeight: self.height.ideal,
            maxHeight: self.height.max
        )
        .readSize { size in
            withAnimation {
                self.currentSize = size
            }
        }
        .padding(.all, self.height.ideal)
        .contentShape(Rectangle())
        .onHover { hovering in
            withAnimation {
                self.isHovered = hovering
            }
        }
        .onTapGesture(perform: self.tap(on:))
        .gesture(
            DragGesture()
                .onChanged(self.dragChanged(on:))
                .onEnded(self.dragEnded(on:))
        )
        .padding(.all, -self.height.ideal)
    }
}

// MARK: - Style

extension Slider {
    private func opacity() -> CGFloat {
        if self.isHovered {
            return 0.8
        }
        
        if self.isDragging {
            return 1.0
        }
        
        return 0.4
    }
}

// MARK: - Gestures

extension Slider {
    private func tap(on location: CGPoint) {
        let width = self.currentSize.width
        self.percentage = location.x / width
    }
    
    private func dragChanged(on value: DragGesture.Value) {
        let width = self.currentSize.width
        let start = value.startLocation.x
        let dragLocation = value.location.x
        let currentLocation = self.percentage * width
        
        if !self.isDragging {
            self.dragDiff = currentLocation - start
        }
        
        let offset = max(0, min(dragLocation + self.dragDiff, width))
        self.percentage = offset / width
        
        withAnimation {
            self.isDragging = true
        }
    }
    
    private func dragEnded(on value: DragGesture.Value) {
        withAnimation {
            self.isDragging = false
        }
    }
}
