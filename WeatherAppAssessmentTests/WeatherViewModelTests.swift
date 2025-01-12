//
//  WeatherViewModelTests.swift
//  WeatherAppAssessmentTests
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import XCTest
import CoreLocation
@testable import WeatherAppAssessment

final class WeatherViewModelTests: XCTestCase {
    private var sut: WeatherViewModel!
    private var mockService: MockWeatherService!
    
    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        sut = WeatherViewModel(service: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testGetWeatherForLocation_Success() async {
        let location = mockLocation()
        let mockCurrentWeather = Mock.currentWeather()
        let mockForecast = Mock.weatherForecast()
        mockService.currentWeatherResponse = mockCurrentWeather
        mockService.forecastResponse = mockForecast
        
        await sut.getWeather(for: location)
        
        guard case .loaded(let weather, let forecast) = sut.status else {
            XCTFail("Expected status to be .loaded, but got \(sut.status)")
            return
        }
        
        let middayMatches = mockForecast.list.count { item in
            let date = Date(timeIntervalSince1970: Double(item.dt))
            let hour = Calendar.current.component(.hour, from: date)
            return hour == 12
        }
        XCTAssertEqual(weather, CurrentWeather(apiResponse: mockCurrentWeather))
        XCTAssertEqual(forecast.count, middayMatches)
    }
    
    func testGetWeatherForLocation_Error() async {
        let location = mockLocation()
        mockService.shouldThrowError = true
        
        await sut.getWeather(for: location)
        
        guard case .error(let description) = sut.status else {
            XCTFail("Expected status to be .error, but got \(sut.status)")
            return
        }
        
        XCTAssertEqual(description, MockWeatherService.mockError.localizedDescription)
    }
    
    func testGetWeatherForCity_Success() async {
        let cityName = "San Francisco"
        let mockCurrentWeather = Mock.currentWeather()
        let mockForecast = Mock.weatherForecast()
        mockService.currentWeatherResponse = mockCurrentWeather
        mockService.cityWeatherResponse = mockCurrentWeather
        mockService.forecastResponse = mockForecast
        
        await sut.getWeather(city: cityName)
        
        guard case .loaded(let weather, let forecast) = sut.status else {
            XCTFail("Expected status to be .loaded, but got \(sut.status)")
            return
        }
        let middayMatches = mockForecast.list.count { item in
            let date = Date(timeIntervalSince1970: Double(item.dt))
            let hour = Calendar.current.component(.hour, from: date)
            return hour == 12
        }
        XCTAssertEqual(weather, CurrentWeather(apiResponse: mockCurrentWeather))
        XCTAssertEqual(forecast.count, middayMatches)
    }
    
    func testGetWeatherForCity_Error() async {
           let cityName = "San Francisco"
           mockService.shouldThrowError = true

           await sut.getWeather(city: cityName)

           guard case .error(let description) = sut.status else {
               XCTFail("Expected status to be .error, but got \(sut.status)")
               return
           }

           XCTAssertEqual(description, MockWeatherService.mockError.localizedDescription)
       }
    
    private func mockLocation() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    }
}

final class MockWeatherService: WeatherService {
    var currentWeatherResponse: CurrentWeatherAPIResponse?
    var forecastResponse: WeatherForecastAPIResponse?
    var cityWeatherResponse: CurrentWeatherAPIResponse?
    var shouldThrowError = false
    
    static let mockError = NSError(domain: "WeatherService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"])
    
    func getCurrentWeather(location: CLLocationCoordinate2D) async throws -> CurrentWeatherAPIResponse {
        if shouldThrowError { throw MockWeatherService.mockError }
        return currentWeatherResponse!
    }
    
    func getFiveDayForecast(location: CLLocationCoordinate2D) async throws -> WeatherForecastAPIResponse {
        if shouldThrowError { throw MockWeatherService.mockError }
        return forecastResponse!
    }
    
    func getWeatherForCity(name: String) async throws -> CurrentWeatherAPIResponse {
        if shouldThrowError { throw MockWeatherService.mockError }
        return cityWeatherResponse!
    }
}
