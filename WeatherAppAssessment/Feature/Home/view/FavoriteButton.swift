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
    @State private var isFavorite = false
    
    @State private var presentWarning = false
    
    func isFavorite(_ name: String) -> Bool {
        var descriptor = FetchDescriptor<FavoriteLocation>()
        descriptor.predicate = #Predicate { item in
            item.name == name
        }
        let filteredList = (try? modelContext.fetch(descriptor)) ?? []
        return !filteredList.isEmpty
    }
    
    func favoriteLocation(_ currentWeather: CurrentWeather) {
        do {
            let item = FavoriteLocation(currentWeather: currentWeather)
            modelContext.insert(item)
            try modelContext.save()
            self.isFavorite = true
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
            self.isFavorite = false
        } catch {
            self.presentWarning = true
        }
    }
    
    func toggleFavorite() {
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
            Image(systemName: isFavorite ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundStyle(isFavorite ? .orange : .primary)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .alert("Operation Failed", isPresented: $presentWarning, actions: {
            Button("Okay") {}
        })
        .onAppear {
            self.isFavorite = isFavorite(currentWeather.name)
        }
    }
}

#Preview {
    FavoriteButton(currentWeather: .init(apiResponse: Mock.currentWeather()))
}
