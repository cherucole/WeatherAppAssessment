//
//  FavoriteButton.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import SwiftUI
import SwiftData

struct FavoriteButton: View {
    let currentWeather: CurrentWeather
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var favorites: [FavoriteLocation]
    
    var favoriteNameSet: Set<String> {
        Set(favorites.map(\.name))
    }
    
    @State private var presentWarning = false
    
    func isFavorite(_ name: String) -> Bool {
        favoriteNameSet.contains(name)
    }
    
    func favoriteLocation(_ currentWeather: CurrentWeather) {
        do {
            let item = FavoriteLocation(currentWeather: currentWeather)
            modelContext.insert(item)
            try modelContext.save()
        } catch {
            self.presentWarning = true
        }
    }
    
    func removeFavorite(_ name: String) {
        var descriptor = FetchDescriptor<FavoriteLocation>()
        descriptor.predicate = #Predicate { item in
            item.name == name
        }
        guard let match = (try? modelContext.fetch(descriptor))?.first else { return }
        modelContext.delete(match)
        do {
            try modelContext.save()
        } catch {
            self.presentWarning = true
        }
    }
    
    func toggleFavorite() {
        let isFavorite = isFavorite(currentWeather.name)
        if isFavorite {
            removeFavorite(currentWeather.name)
        } else {
            favoriteLocation(currentWeather)
        }
    }
    
    var body: some View {
        Button {
            toggleFavorite()
        } label: {
            Image(systemName: isFavorite(currentWeather.name) ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundStyle(isFavorite(currentWeather.name) ? .orange : .primary)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .alert("Operation Failed", isPresented: $presentWarning, actions: {
            Button("Okay") {}
        })
    }
}

#Preview {
    FavoriteButton(currentWeather: .init(apiResponse: Mock.currentWeather()))
}
