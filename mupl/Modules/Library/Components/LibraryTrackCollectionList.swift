//
//  LibraryAlbumsList.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 26.02.2024.
//

import SwiftUI
import MusicKit

extension LibraryView {
    struct TrackCollectionList<MusicItemType: MusicTrackCollection>: View where MusicItemType: MusicLibraryRequestable {
        @State private var items: LoadableValue<MusicItemCollection<MusicItemType>> = .init()
        
        @EnvironmentObject private var musicCatalog: MusicCatalog
        
        var body: some View {
            ZStack {
                switch self.items.status {
                case .idle, .error:
                    Color.clear
                case .loading:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .loaded(let items):
                    self.content(items)
                }
            }
            .animation(.easeIn, value: self.items.status)
            .onAppear {
                self.items.load {
                    await self.musicCatalog.personal.library(of: MusicItemType.self)
                }
            }
        }
        
        // MARK: - Components
        
        private func content(_ items: MusicItemCollection<MusicItemType>) -> some View {
            ScrollView {
                LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 4), spacing: 24.0) {
                    ForEach(items, id: \.self) { item in
                        ZStack {
                            NavigationLink(value: item) {
                                TrackCollectionItem(item: item, kind: .medium)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.vertical, 24.0)
            }
        }
    }
}
