//
//  CurrentWeatherAPIResponse.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import Foundation

struct CurrentWeatherAPIResponse: Codable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    struct Coord: Codable, Equatable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable, Equatable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable, Equatable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int?
        let grndLevel: Int?
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }
    
    struct Wind: Codable, Equatable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }
    
    struct Rain: Codable, Equatable {
        let oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
    
    struct Clouds: Codable, Equatable {
        let all: Int
    }
    
    struct Sys: Codable, Equatable {
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
