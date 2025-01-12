//
//  LocationViewModel.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import Foundation
import MapKit
import OSLog

fileprivate let logger = Logger.createLog(category: "LocationViewModel")

@Observable
final class LocationViewModel {
    var locationManager: CLLocationManager?
    
    var presentLocationServicesDisabledWarning = false
    var presentLocationRestrictedWarning = false
    var presentLocationDeniedWarning = false
    
    var cordinates: CLLocationCoordinate2D?
    
    func setupLocationServices(delegate: CLLocationManagerDelegate) {
        guard CLLocationManager.locationServicesEnabled() else {
            presentLocationServicesDisabledWarning = true
            return
        }
        locationManager = CLLocationManager()
        locationManager!.delegate = delegate
        updateLocationAuthorizationStatus()
    }
    
    private func updateLocationAuthorizationStatus() {
        guard let locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            presentLocationRestrictedWarning = true
        case .denied:
            presentLocationDeniedWarning = true
        case .authorizedAlways, .authorizedWhenInUse:
            guard let cordinates = locationManager.location?.coordinate else { return }
            self.cordinates = cordinates
            logger.info("cordinates are: lat \(cordinates.latitude), long \(cordinates.longitude)")
        @unknown default:
            break
        }
    }
    
    func getUserLocation() -> CLLocationCoordinate2D? {
        locationManager?.location?.coordinate
    }
}

