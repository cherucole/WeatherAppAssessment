//
//  WeatherViewModel.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation
import SwiftUI
import MapKit

@Observable
final class WeatherViewModel {
    enum Status {
        case idle
        case loading
        case loaded(weather: CurrentWeather, forecast: [ForecastItem])
        case error(description: String)
    }
    
    let service: WeatherService
    
    init(service: WeatherService = WeatherService()) {
        self.service = service
    }
    
    var status: Status = .idle
    let calendar = Calendar.current
    
    func getWeather(for location: CLLocationCoordinate2D) async {
        status = .loading
        do {
            async let currentWeatherRequest = try service.getCurrentWeather(location: location)
            async let weatherForecastRequest = try service.getFiveDayForecast(location: location)
            let (weatherResponse, forecastResponse) = try await (currentWeatherRequest, weatherForecastRequest)
            let currentWeather = CurrentWeather(apiResponse: weatherResponse)
            let forecastItems = forecastResponse.list.map({ ForecastItem(apiResponse: $0) }).filter { item in
                let hour = calendar.component(.hour, from: item.date)
                return hour == 12
            }
            status = .loaded(weather: currentWeather, forecast: forecastItems)
        } catch {
            status = .error(description: error.localizedDescription)
        }
    }
}
