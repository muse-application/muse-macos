//
//  View + Debouncer.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 10.02.2024.
//

import SwiftUI

private struct DebouncerViewModifier<Value: Equatable>: ViewModifier {
    private let value: Value
    private let debounceDuration: Duration
    private let action: (Value) -> Void
    
    @State private var task: Task<Void, Never>?
    
    init(value: Value, debounceDuration: Duration, action: @escaping (Value) -> Void) {
        self.value = value
        self.debounceDuration = debounceDuration
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: self.value) { _, newValue in
                self.task?.cancel()
                self.task = Task {
                    do { try await Task.sleep(for: self.debounceDuration) } catch { return }
                    self.action(newValue)
                }
            }
    }
}

extension View {
    func onChange<Value: Equatable>(of value: Value, debounce: Duration, action: @escaping (Value) -> Void) -> some View {
        return self.modifier(DebouncerViewModifier(value: value, debounceDuration: debounce, action: action))
    }
}
