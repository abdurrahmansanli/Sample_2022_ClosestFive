//
//  MainPageViewModel.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

final class MainPageViewModel {
    
    var closurePlacesDidUpdate: (() -> Void)?
    
    var closurePlacesWillUpdate: (() -> Void)?
    
    var places = [Place]()
    
    private let placesApi: PlacesApi
    
    private let placesDatabaseManager: PlacesDatabaseManager
    
    private let maximumItemCount = 5
    
    init(placesApi: PlacesApi, placesDatabaseManager: PlacesDatabaseManager) {
        self.placesApi = placesApi
        self.placesDatabaseManager = placesDatabaseManager
    }
    
    convenience init() {
        self.init(placesApi: PlacesApi(), placesDatabaseManager: PlacesDatabaseManager())
    }
    
    func refreshPlaces() {
        closurePlacesWillUpdate?()
        placesApi.getPlaces(latitude: 45.0086,
                            longitude: 28.8644) { placesResponse in
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
 
