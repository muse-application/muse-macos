//
//  LoadableValue.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 29.01.2024.
//

import Foundation

@Observable
class LoadableValue<T: Hashable> {
    enum Status: Hashable, Equatable {
        case idle
        case loading
        case loaded(T)
        case error(AppError)
        
        var isLoaded: Bool {
            if case .loaded = self {
                return true
            }
            
            return false
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .idle:
                hasher.combine(0)
            case .loading:
                hasher.combine(1)
            case .loaded(let value):
                hasher.combine(2)
                hasher.combine(value)
            case .error(let error):
                hasher.combine(3)
                hasher.combine(error)
            }
        }
        
        static func == (lhs: Status, rhs: Status) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }
    
    private(set) var status: Status = .idle
    
    private var task: Task<Void, Never>?
    
    var value: T? {
        if case .loaded(let value) = self.status {
            return value
        }
        
        return nil
    }
    
    func load(_ task: @Sendable @escaping () async throws -> T) {
        self.task?.cancel()
        self.status = .loading
        
        self.task = Task {
            do {
                let result = try await task()
                self.status = .loaded(result)
            } catch {
                if let error = error as? AppError {
                    self.status = .error(error)
                } else {
                    self.status = .error(.internal)
                }
            }
        }
    }
    
    func reset() {
        self.task?.cancel()
        self.status = .idle
    }
}
