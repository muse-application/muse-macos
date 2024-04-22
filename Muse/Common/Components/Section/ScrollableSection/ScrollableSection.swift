//
//  ScrollableSection.swift
//  Muse
//
//  Created by Tamerlan Satualdypov on 06.01.2024.
//

import SwiftUI

struct ScrollableSection<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    private let title: String
    private let items: Data
    private let itemIDKeyPath: KeyPath<Data.Element, ID>
    private let itemBuilder: (Data.Element) -> Content
    
    init(title: String, items: Data, id: KeyPath<Data.Element, ID>, itemBuilder: @escaping (Data.Element) -> Content) {
        self.title = title
        self.items = items
        self.itemIDKeyPath = id
        self.itemBuilder = itemBuilder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .s3) {
            Text(self.title)
                .font(.system(size: 16.0, weight: .bold))
                .foregroundStyle(Color.primaryText)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: .s4) {
                    ForEach(self.items, id: self.itemIDKeyPath) { item in
                        self.itemBuilder(item)
                    }
                    .scrollTransition { view, phase in
                        view.opacity(phase.isIdentity ? 1.0 : 0.0)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 24.0)
            }
            .scrollTargetBehavior(.viewAligned)
            .padding(.horizontal, -24.0)
        }
    }
}

// MARK: - Skeleton

extension ScrollableSection {
    struct Skeleton<SkeletonItem: View>: View where Data == EmptyCollection<Any>, ID == Never, Content == Never {
        private let quantity: Int
        private let itemBuilder: () -> SkeletonItem
        
        init(quantity: Int, itemBuilder: @escaping () -> SkeletonItem) {
            self.quantity = quantity
            self.itemBuilder = itemBuilder
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: .s3) {
                Color.tertiaryFill
                    .frame(width: 150.0, height: 16.0)
                    .clipShape(.rect(cornerRadius: 4.0))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: .s4) {
                        ForEach(0 ..< self.quantity, id: \.self) { _ in
                            self.itemBuilder()
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal, 24.0)
                }
                .scrollTargetBehavior(.viewAligned)
                .padding(.horizontal, -24.0)
            }
        }
    }
}


// MARK: - Convenience Initializers

extension ScrollableSection where Data.Element: Identifiable, Data.Element.ID == ID {
    init(title: String, items: Data, itemBuilder: @escaping (Data.Element) -> Content) {
        self.init(title: title, items: items, id: \.id, itemBuilder: itemBuilder)
    }
}
