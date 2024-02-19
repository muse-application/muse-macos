//
//  ArtistDetailsLatestReleaseSection.swift
//  mupl
//
//  Created by Tamerlan Satualdypov on 15.02.2024.
//

import SwiftUI
import MusicKit

extension ArtistDetailsSectionProvider {
    struct LatestReleaseSection: ProvidableSection {
        func section(with value: Album) -> some View {
            VStack(alignment: .leading, spacing: 16.0) {
                Text("Latest Release")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(Color.primaryText)
                
                NavigationLink(value: value) {
                    HStack {
                        HStack(spacing: 16.0) {
                            MusicArtworkImage(artwork: value.artwork)
                                .frame(width: 80.0, height: 80.0)
                                .clipShape(.rect(cornerRadius: 8.0))
                            
                            VStack(alignment: .leading, spacing: 4.0) {
                                if let releaseDate = value.releaseDate {
                                    Text(releaseDate.format("dd MMM YYYY").uppercased())
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(Color.secondaryText)
                                }
                                
                                VStack(alignment: .leading, spacing: 2.0) {
                                    Text(value.title)
                                        .font(.system(size: 14.0, weight: .semibold))
                                        .foregroundStyle(Color.primaryText)
                                    
                                    Text("\(value.trackCount) songs")
                                        .font(.system(size: 12.0, weight: .medium))
                                        .foregroundStyle(Color.secondaryText)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8.0) {
                            Button {
                                
                            } label: {
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 24.0))
                                    .symbolRenderingMode(.multicolor)
                                    .foregroundStyle(Color.pinkAccent)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis.circle.fill")
                                    .font(.system(size: 24.0))
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(Color.pinkAccent)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 12.0)
                    .padding(.horizontal, 16.0)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 8.0))
                    .border(style: .quinaryFill, cornerRadius: 8.0)
                }
                .buttonStyle(.plain)
            }
        }
        
        func skeleton() -> some View {
            VStack(alignment: .leading, spacing: 16.0) {
                Color.tertiaryFill
                    .frame(width: 150.0, height: 16.0)
                    .clipShape(.rect(cornerRadius: 4.0))
                
                Color.tertiaryFill
                    .frame(height: 100.0)
                    .frame(maxWidth: .infinity)
                    .clipShape(.rect(cornerRadius: 8.0))
            }
        }
    }
}
