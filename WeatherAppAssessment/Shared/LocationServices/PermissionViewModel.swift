//
//  PermissionViewModel.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import SwiftUI
import CoreLocation

@Observable
final class PermissionViewModel: NSObject, CLLocationManagerDelegate {
    static var shared = PermissionViewModel()
    
    private override init() {}

    @MainActor var status: CLAuthorizationStatus = .notDetermined
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            self.status = manager.authorizationStatus
        }
    }
}
