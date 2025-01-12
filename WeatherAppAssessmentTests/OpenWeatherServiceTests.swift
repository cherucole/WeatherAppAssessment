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
        let location = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let expectedResponse = Mock.currentWeather()
        mockClient.mockResponse = (try JSONEncoder().encode(expectedResponse), HTTPURLResponse(statusCode: 200))
        
        // when
        let result = try await sut.getCurrentWeather(location: location)
        
        // then
        XCTAssertEqual(result, expectedResponse)
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
