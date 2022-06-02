//
//  LocationService.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 23.05.2022.
//

import CoreLocation

enum UpdateError {
    case denied
    case notDetermined
    case restricted
    case unknown
}

protocol LocationServiceDelegate: AnyObject {
    func closureDidUpdateLocation(location: CLLocation)
    func closureDidReceiveUpdateError(updateError: UpdateError)
    func receivedSameLocation()
}

class LocationService: NSObject {
     
    weak var delegate: LocationServiceDelegate?
    
    private var previousLocation: CLLocation?
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()
    
    func updateLocationIfAppropriate() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways:
            locationManager.requestLocation()
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            delegate?.closureDidReceiveUpdateError(updateError: .denied)
        case .notDetermined:
            requestAuthorization()
        case .restricted:
            delegate?.closureDidReceiveUpdateError(updateError: .restricted)
        @unknown default:
            delegate?.closureDidReceiveUpdateError(updateError: .unknown)
        }
    }
    
    private func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        if location.coordinate.latitude == previousLocation?.coordinate.latitude &&
            location.coordinate.longitude == previousLocation?.coordinate.longitude {
            delegate?.receivedSameLocation()
        } else {
            previousLocation = location
            delegate?.closureDidUpdateLocation(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.closureDidReceiveUpdateError(updateError: .unknown)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateLocationIfAppropriate()
    }
}
