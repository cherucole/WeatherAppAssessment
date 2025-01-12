//
//  FavoritesList.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import SwiftUI
import SwiftData

struct FavoritesList: View {
    let onSelect: (FavoriteLocation) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @Query private var favorites: [FavoriteLocation]
    
    var body: some View {
        NavigationStack {
            VStack {
                if favorites.isEmpty {
                    ContentUnavailableView {
                        Label("No Favorite Locations", systemImage: "star.circle.fill")
                    } description: {
                        Text("Add favorite locations for quick access")
                    } actions: {
                        Button("Done") {
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(favorites) { favorite in
                            Button {
                                onSelect(favorite)
                                dismiss()
                            } label: {
                                HStack {
                                    Text(favorite.name.getAcronym())
                                        .font(.title3)
                                        .frame(width: 44, height: 44)
                                        .background(Material.regular)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Text(favorite.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.title3)
                                .entireFramePressable()
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoritesList(onSelect: {_ in})
}
