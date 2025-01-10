//
//  CLLocationCoordinate2D+Ext.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        (lhs.latitude, lhs.longitude) == (rhs.latitude, rhs.longitude)
    }
}
