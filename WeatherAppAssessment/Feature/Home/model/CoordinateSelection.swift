//
//  CoordinateSelection.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import Foundation
import MapKit

struct CoordinateSelection: Identifiable {
    let id = UUID()
    let coordinates: CLLocationCoordinate2D
}
