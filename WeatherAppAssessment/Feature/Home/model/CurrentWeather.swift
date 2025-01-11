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
    let maxTemp: Double
}

extension CurrentWeather {
    init(apiResponse: CurrentWeatherAPIResponse) {
        self.temperature = apiResponse.main.temp
        self.description = apiResponse.weather.first?.main ?? "Clear"
        self.minTemp = apiResponse.main.tempMin
        self.maxTemp = apiResponse.main.tempMax
    }
}


