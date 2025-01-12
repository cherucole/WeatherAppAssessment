//
//  HTTPClient.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 08/01/2025.
//

import Foundation

protocol HTTPClient {
    func request(request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
