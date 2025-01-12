//
//  WeatherForecastAPIResponse.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation

struct WeatherForecastAPIResponse: Codable, Equatable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherResponse]
    
    struct WeatherResponse: Codable, Equatable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
        }

        struct Main: Codable, Equatable {
            let temp: Double
            let feelsLike: Double
            let tempMin: Double
            let tempMax: Double
            let pressure: Int
            let seaLevel: Int
            let grndLevel: Int
            let humidity: Int
            let tempKf: Double

            enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure
                case seaLevel = "sea_level"
                case grndLevel = "grnd_level"
                case humidity
                case tempKf = "temp_kf"
            }
        }

        struct Weather: Codable, Equatable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }

        struct Clouds: Codable, Equatable {
            let all: Int
        }

        struct Wind: Codable, Equatable {
            let speed: Double
            let deg: Int
            let gust: Double
        }

        struct Sys: Codable, Equatable {
            let pod: String
        }
    }

}

