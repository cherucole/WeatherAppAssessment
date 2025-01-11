//
//  CurrentWeather.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation

struct CurrentWeather {
    let temperature: Double
    let description: String
    let minTemp: Double
    let currentTemp: Double
    let maxTemp: Double
}

struct ForecastItem {
    let day: String
    let condition: String
    let temperature: Double
}
