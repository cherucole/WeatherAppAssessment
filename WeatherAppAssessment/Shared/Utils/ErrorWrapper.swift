//
//  ErrorWrapper.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation

struct ErrorWrapper: LocalizedError {
    public let errorDescription: String?
    
    public init(_ description: String) {
        self.errorDescription = description
    }
}
