//
//  MainPageViewModel.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

final class MainPageViewModel {
    
    var closurePlacesDidUpdate: (() -> Void)?
    
    var places = [Place]()
    
    private let placesApi: PlacesApi
    
    init(placesApi: PlacesApi) {
        self.placesApi = placesApi
    }
    
    convenience init() {
        self.init(placesApi: PlacesApi())
    }
    
    func refreshPlaces() {
        placesApi.getPlaces(latitude: 41.0086,
                            longitude: 28.8644) { placesResponse in
            self.places = placesResponse.results
            self.closurePlacesDidUpdate?()
        } failure: {
            //TODO: Handle failure
        }
    }
}
 
