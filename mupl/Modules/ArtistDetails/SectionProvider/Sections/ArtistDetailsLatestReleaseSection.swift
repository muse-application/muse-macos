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
                
                HStack {
                    NavigationLink(value: value) {
                        HStack(spacing: 16.0) {
                            MusicArtworkImage(artwork: value.artwork, width: 80.0, height: 80.0)
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
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .font(.system(size: 14.0))
                                .foregroundStyle(Color.secondaryText)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 12.0)
                .padding(.horizontal, 16.0)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8.0))
                .border(style: .quinaryFill, cornerRadius: 8.0)
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
