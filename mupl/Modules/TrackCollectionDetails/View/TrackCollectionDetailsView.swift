//
//  TrackCollectionDetailsView.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 14.01.2024.
//

import SwiftUI
import MusicKit

struct TrackCollectionDetailsView: View {
    private let item: MusicTrackCollection
    
    @Environment(\.playbarHeight) private var playbarHeight
    
    init(item: MusicTrackCollection) {
        self.item = item
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            InfoView(item: self.item)
            SongList(songsProvider: self.item.songsProvider)
        }
        .padding([.top, .horizontal], 24.0)
        .padding(.bottom, self.playbarHeight)
    }
}
