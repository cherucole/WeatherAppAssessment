//
//  APIClient.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 08/01/2025.
//

import Foundation

struct APIClient: HTTPClient {
    enum Error: Swift.Error, LocalizedError {
        case failedDecodingResponse
        
        var errorDescription: String? {
            switch self {
            case .failedDecodingResponse: "Failed to decode response"
            }
        }
    }
    
    private let service: URLSession
    
    init(service: URLSession = .shared) {
        self.service = service
    }
    
    func request(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await service.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw Error.failedDecodingResponse
        }
        return (data, response)
    }
}
