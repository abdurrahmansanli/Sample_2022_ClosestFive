//
//  VenuesViewModel.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

import CoreLocation

enum LocationPermissionState {
    case locationPermissionNotDetermined
    case locationPermissionGiven
    case locationPermissionNotGiven
}

final class VenuesViewModel {
    
    var places = [Place]()
    
    var closurePlacesWillUpdate: (() -> Void)?
    var closurePlacesDidUpdate: (() -> Void)?
    var closureLocationPermissionStateDidUpdate: ((LocationPermissionState) -> Void)?
    
    private var state: LocationPermissionState = .locationPermissionNotDetermined {
        didSet {
            closureLocationPermissionStateDidUpdate?(state)
        }
    }
    
    private let placesApi: PlacesApi
    
    private let placesDatabaseManager: PlacesDatabaseManager
    
    private let locationService: LocationService
    
    private let maximumItemCount = 5
    
    init(placesApi: PlacesApi,
         placesDatabaseManager: PlacesDatabaseManager,
         locationService: LocationService) {
        self.placesApi = placesApi
        self.placesDatabaseManager = placesDatabaseManager
        self.locationService = locationService
        self.locationService.delegate = self
    }
    
    convenience init() {
        self.init(placesApi: PlacesApi(),
                  placesDatabaseManager: PlacesDatabaseManager(),
                  locationService: LocationService())
    }
    
    func refresh() {
        closurePlacesWillUpdate?()
        locationService.updateLocationIfAppropriate()
    }
    
    private func refreshPlaces(latitude: Double, longitude: Double) {
        placesApi.getPlaces(latitude: latitude, longitude: longitude) { placesResponse in
            self.places = placesResponse.results.prefix(self.maximumItemCount).map { $0 }
            self.placesDatabaseManager.savePlacesResponse(placesResponse)
            self.closurePlacesDidUpdate?()
        } failure: {
            self.placesDatabaseManager.getPlacesResponse { placesResponse in
                if let placesResponse = placesResponse {
                    self.places = placesResponse.results.prefix(self.maximumItemCount).map { $0 }
                }
                self.closurePlacesDidUpdate?()
            }
        }
    }
}

extension VenuesViewModel: LocationServiceDelegate {
    func closureDidUpdateLocation(location: CLLocation) {
        refreshPlaces(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        state = .locationPermissionGiven
    }
    
    func closureDidReceiveUpdateError(updateError: UpdateError) {
        switch updateError {
        case .denied:
            state = .locationPermissionNotGiven
        case .notDetermined:
            state = .locationPermissionNotGiven
        case .restricted:
            state = .locationPermissionNotGiven
        case .unknown:
            self.closurePlacesDidUpdate?()
        }
    }
    
    func receivedSameLocation() {
        state = .locationPermissionGiven
        self.closurePlacesDidUpdate?()
    }
}
