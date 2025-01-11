//
//  WeatherService.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import Foundation
import MapKit
import OSLog

fileprivate let logger = Logger.createLog(category: "WeatherService")

struct WeatherService {
    let client: HTTPClient
    
    init(client: HTTPClient = APIClient()) {
        self.client = client
    }
    
    let parser = DataParser()
    
    func getCurrentWeather(location: CLLocationCoordinate2D) async throws -> CurrentWeatherAPIResponse {
        let currentWeatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstants.openWeatherAPIKey)&units=metric"
        let request = try urlRequest(urlString: currentWeatherBaseURL)
        let (data, response) = try await client.request(request: request)
        guard response.statusCode == 200 else {
            logger.warning("Failed to get current weather")
            throw Error.other(message: "Failed to get current weather")
        }
        let weatherResponse: CurrentWeatherAPIResponse = try parser.parse(data: data)
        logger.log("Current weather retrieved successfully")
        return weatherResponse
    }
    
    func getFiveDayForecast(location: CLLocationCoordinate2D) async throws -> WeatherForecastAPIResponse {
        let forecastBaseURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIConstants.openWeatherAPIKey)&units=metric"
        let request = try urlRequest(urlString: forecastBaseURL)
        let (data, response) = try await client.request(request: request)
        guard response.statusCode == 200 else {
            logger.warning("Failed to get current weather")
            throw Error.other(message: "Failed to get current weather")
        }
        let forecastResponse: WeatherForecastAPIResponse = try parser.parse(data: data)
        logger.log("weather forecast retrieved successfully")
        return forecastResponse
    }
    
    private func urlRequest(urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw Error.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

extension WeatherService {
    enum Error: Swift.Error, LocalizedError {
        case invalidURL
        case other(message: String)
        
        var errorDescription: String? {
            "Request Failed"
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .invalidURL: "Invalid URL provided for the request"
            case .other(let message): message
            }
        }
    }
}
