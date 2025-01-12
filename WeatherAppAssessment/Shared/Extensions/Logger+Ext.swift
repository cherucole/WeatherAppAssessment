//
//  Logger+Ext.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import Foundation
import OSLog

extension Logger {
    static func createLog(category: String) -> Logger {
        Logger(subsystem: Bundle.main.bundleIdentifier!, category: category)
    }
}
