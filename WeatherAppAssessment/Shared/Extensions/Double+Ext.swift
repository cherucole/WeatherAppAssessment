//
//  Double+Ext.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation

extension Double {
    func toTemperatureString() -> String {
        return String(format: "%.0f°", self)
    }
}
