//
//  OpenWeatherServiceTests.swift
//  WeatherAppAssessmentTests
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import XCTest
@testable import WeatherAppAssessment
import MapKit

final class OpenWeatherServiceTests: XCTestCase {
    var mockClient: MockHTTPClient!
    var sut: OpenWeatherService!
    
    override func setUp() {
        super.setUp()
        mockClient = MockHTTPClient()
        sut = OpenWeatherService(client: mockClient)
    }
    
    override func tearDown() {
        mockClient = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetCurrentWeather_Success() async throws {
        // given
        let location = mockLocation()
        let expectedResponse = Mock.currentWeather()
        mockClient.mockResponse = (try JSONEncoder().encode(expectedResponse), HTTPURLResponse(statusCode: 200))
        
        // when
        let result = try await sut.getCurrentWeather(location: location)
        
        // then
        XCTAssertEqual(result, expectedResponse)
    }
    
    func testGetCurrentWeather_Failure_InvalidResponse() async {
        let location = mockLocation()
        mockClient.mockResponse = (Data(), HTTPURLResponse(statusCode: 400))
        do {
            _ = try await sut.getCurrentWeather(location: location)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is OpenWeatherService.Error)
        }
    }
    
    func testGetFiveDayForecast_Success() async throws {
        let location = mockLocation()
        let expectedResponse = Mock.weatherForecast()
        mockClient.mockResponse = (try JSONEncoder().encode(expectedResponse), HTTPURLResponse(statusCode: 200))
        
        let result = try await sut.getFiveDayForecast(location: location)
        
        XCTAssertEqual(result, expectedResponse)
    }
    
    func testGetFiveDayForecast_Failure_InvalidResponse() async {
        let location = mockLocation()
        mockClient.mockResponse = (Data(), HTTPURLResponse(statusCode: 400))
        do {
            _ = try await sut.getFiveDayForecast(location: location)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is OpenWeatherService.Error)
        }
    }
    
    func testGetWeatherForCity_Success() async throws {
        let cityName = "San Francisco"
        let expectedResponse = Mock.currentWeather()
        mockClient.mockResponse = (try JSONEncoder().encode(expectedResponse), HTTPURLResponse(statusCode: 200))
        
        let result = try await sut.getWeatherForCity(name: cityName)
        
        XCTAssertEqual(result, expectedResponse)
    }
    
    func testGetWeatherForCity_Failure_InvalidResponse() async {
        let cityName = "San Francisco"
        mockClient.mockResponse = (Data(), HTTPURLResponse(statusCode: 400))

        do {
            _ = try await sut.getWeatherForCity(name: cityName)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is OpenWeatherService.Error)
        }
    }
    
    private func mockLocation() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    }
}

final class MockHTTPClient: HTTPClient {
    var mockResponse: (Data, HTTPURLResponse)?
    var lastRequest: URLRequest?
    
    func request(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        lastRequest = request
        guard let mockResponse = mockResponse else {
            throw NSError(domain: "MockError", code: -1)
        }
        return mockResponse
    }
}

// MARK: - Helper Extensions

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: URL(string: "https://example.com")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
