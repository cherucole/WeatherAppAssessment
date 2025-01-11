//
//  FavoritesList.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import SwiftUI
import SwiftData

struct FavoritesList: View {
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
                            Text(favorite.name)
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
    FavoritesList()
}
