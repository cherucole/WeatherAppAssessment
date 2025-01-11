//
//  Mock.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import Foundation

struct Mock {
    enum ServiceError: LocalizedError {
        case missingFile
        
        var errorDescription: String? {
            "Something went wrong fetching currencies"
        }
    }
    
    static let parser = DataParser()
    
    static func currentWeather() -> CurrentWeatherAPIResponse {
        let data = try! loadFileContents(fileName: "currentWeatherResponse")
        return try! parser.parse(data: data)
    }
    
    static func weatherForecast() -> WeatherForecastAPIResponse {
        let data = try! loadFileContents(fileName: "weatherForecastResponse")
        return try! parser.parse(data: data)
    }
    
    private static func loadFileContents(fileName: String) throws -> Data { // need to correctly add resources in package config for bundle.module to be available
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { throw ServiceError.missingFile }
        let data = try Data(contentsOf: url)
        return data
    }
}
