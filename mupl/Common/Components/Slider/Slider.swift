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
    
    private var onDragAction: (() -> Void)?
    private var onChangeAction: ((CGFloat) -> Void)? = nil
    
    @State private var dragDiff: CGFloat = 0.0
    @State private var currentSize: CGSize = .zero
    @State private var isHovered: Bool = false
    @State private var isDragging: Bool = false
    
    @Binding private var percentage: CGFloat
    
    init(width: Dimension, height: Dimension = .constant(4.0), percentage: Binding<CGFloat>) {
        self.width = width
        self.height = height
        
        self._percentage = percentage
    }
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
            Color.secondaryFill
                .clipShape(.rect(cornerRadius: self.currentSize.height / 2.0))
            
            Color.primaryFill
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
            self.currentSize = size
        }
        .padding(.all, self.height.ideal)
        .contentShape(Rectangle())
        .onHover { hovering in
            self.isHovered = hovering
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
        if self.isDragging {
            return 1.0
        }
        
        if self.isHovered {
            return 0.8
        }
        
        return 0.6
    }
}

// MARK: - Gestures

extension Slider {
    private func tap(on location: CGPoint) {
        let width = self.currentSize.width
        self.percentage = location.x / width
        self.onChangeAction?(self.percentage)
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
        
        self.isDragging = true
        self.onDragAction?()
    }
    
    private func dragEnded(on value: DragGesture.Value) {
        self.isDragging = false
        self.onChangeAction?(self.percentage)
    }
}

// MARK: - Modifiers

extension Slider {
    func onDrag(_ action: @escaping () -> Void) -> Self {
        var _self = self
        _self.onDragAction = action
        return _self
    }
    
    func onChange(_ action: @escaping (CGFloat) -> Void) -> Self {
        var _self = self
        _self.onChangeAction = action
        return _self
    }
}
