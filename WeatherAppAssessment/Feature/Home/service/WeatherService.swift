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
    
    func getCurrentWeather(location: CLLocationCoordinate2D) async throws {
        let request = try currentWeatherRequest(location: location)
        let (data, response) = try await client.request(request: request)
        guard response.statusCode == 200 else {
            logger.warning("Failed to get current weather")
            throw Error.other(message: "Failed to get current weather")
        }
        let weatherResponse: CurrentWeatherAPIResponse = try parser.parse(data: data)
        logger.log("Current weather retrieved successfully")
    }
    
    private func currentWeatherRequest(location: CLLocationCoordinate2D) throws -> URLRequest {
        let latitude = location.latitude.formatted(.number.precision(.fractionLength(2)))
        let longitude = location.longitude.formatted(.number.precision(.fractionLength(2)))
        let currentWeatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIConstants.openWeatherAPIKey)"
        guard let url = URL(string: currentWeatherBaseURL) else {
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
