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
    let service: WeatherService
    
    init(service: WeatherService = WeatherService()) {
        self.service = service
    }
    
    var currentWeather: CurrentWeather?
    var forecastItems: [ForecastItem] = []
    
    var presentError = false
    var error: ErrorWrapper?
    
    let calendar = Calendar.current
    
    func getWeather(for location: CLLocationCoordinate2D) async {
        do {
            async let currentWeather = try service.getCurrentWeather(location: location)
            async let weatherForecast = try service.getFiveDayForecast(location: location)
            let (weatherResponse, forecastResponse) = try await (currentWeather, weatherForecast)
            self.currentWeather = CurrentWeather(apiResponse: weatherResponse)
            let items = forecastResponse.list.map({ ForecastItem(apiResponse: $0) }).filter { item in
                let hour = calendar.component(.hour, from: item.date)
                return hour == 12
            }
            self.forecastItems = items
        } catch {
            self.presentError = true
            self.error = .init(error.localizedDescription)
        }
    }
}
