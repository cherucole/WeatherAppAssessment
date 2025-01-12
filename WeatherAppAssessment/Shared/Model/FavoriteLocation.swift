//
//  FavoriteLocation.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation
import SwiftData

@Model
final class FavoriteLocation {
    #Unique<FavoriteLocation>([\.name])
    var coordinates: Coordinates
    var name: String
    var date: Date
    
    init(
        coordinates: Coordinates,
        name: String,
        date: Date
    ) {
        self.coordinates = coordinates
        self.name = name
        self.date = date
    }
    
    struct Coordinates: Codable {
        let longitude: Double
        let latitude: Double
    }
}

extension FavoriteLocation {
    convenience init(currentWeather: CurrentWeather) {
        self.init(
            coordinates: .init(
                longitude: currentWeather.coordinates.longitude,
                latitude: currentWeather.coordinates.latitude
            ),
            name: currentWeather.name,
            date: currentWeather.date
        )
    }
}
