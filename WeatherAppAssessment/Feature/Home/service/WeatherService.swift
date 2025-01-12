//
//  WeatherService.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import Foundation
import CoreLocation

protocol WeatherService {
    func getCurrentWeather(location: CLLocationCoordinate2D) async throws -> CurrentWeatherAPIResponse
    func getFiveDayForecast(location: CLLocationCoordinate2D) async throws -> WeatherForecastAPIResponse
    func getWeatherForCity(name: String) async throws -> CurrentWeatherAPIResponse
}
