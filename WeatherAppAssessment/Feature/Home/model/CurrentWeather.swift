//
//  CurrentWeather.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation
import CoreLocation

struct CurrentWeather: Equatable {
    let temperature: Double
    let description: String
    let minTemp: Double
    let maxTemp: Double
    let name: String
    let coordinates: CLLocationCoordinate2D
    let date: Date
    let sunrise: Date
    let sunset: Date
    let country: String
}

extension CurrentWeather {
    init(apiResponse: CurrentWeatherAPIResponse) {
        self.temperature = apiResponse.main.temp
        self.description = apiResponse.weather.first?.main ?? "Clear"
        self.minTemp = apiResponse.main.tempMin
        self.maxTemp = apiResponse.main.tempMax
        self.name = apiResponse.name
        self.coordinates = .init(latitude: apiResponse.coord.lat, longitude: apiResponse.coord.lon)
        self.date = Date(timeIntervalSince1970: Double(apiResponse.dt))
        self.sunrise = Date(timeIntervalSince1970: Double(apiResponse.sys.sunrise))
        self.sunset = Date(timeIntervalSince1970: Double(apiResponse.sys.sunset))
        self.country = apiResponse.sys.country
    }
}


