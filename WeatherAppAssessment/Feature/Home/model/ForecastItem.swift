//
//  ForecastItem.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation

struct ForecastItem: Identifiable {
    let id = UUID()
    let date: Date
    let condition: String
    let temperature: Double
}

extension ForecastItem {
    init(apiResponse: WeatherForecastAPIResponse.WeatherResponse) {
        self.date = Date(timeIntervalSince1970: Double(apiResponse.dt))
        self.condition = apiResponse.weather.first?.main ?? "Clear"
        self.temperature = apiResponse.main.temp
    }
}
