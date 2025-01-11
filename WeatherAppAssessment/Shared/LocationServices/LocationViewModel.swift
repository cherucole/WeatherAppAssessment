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
//    var delegate: CLLocationManagerDelegate
    
    var presentLocationServicesDisabledWarning = false
    var presentLocationRestrictedWarning = false
    var presentLocationDeniedWarning = false
    
    var cordinates: CLLocationCoordinate2D?
    
//    init(delegate: CLLocationManagerDelegate) {
//        guard CLLocationManager.locationServicesEnabled() else {
//            presentLocationServicesDisabledWarning = true
//            return
//        }
////        self.delegate = delegate
//        let locationManager = CLLocationManager()
//        locationManager.delegate = delegate
//        self.locationManager = locationManager
//    }
    
    func checkIfLocationServicesEnabled() {
//        guard CLLocationManager.locationServicesEnabled() else {
//            presentLocationServicesDisabledWarning = true
//            return
//        }
//        locationManager = CLLocationManager()
//        locationManager!.delegate = self
    }
    
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
    
//    func getAuthorizationStatus() -> CLAuthorizationStatus {
//        locationManager!.authorizationStatus
//    }
    
    func getUserLocation() -> CLLocationCoordinate2D? {
        locationManager?.location?.coordinate
    }
    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        updateLocationAuthorizationStatus()
//    }
}

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
