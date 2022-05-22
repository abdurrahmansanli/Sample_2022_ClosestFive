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
    
    private let maximumItemCount = 5
    
    init(placesApi: PlacesApi) {
        self.placesApi = placesApi
    }
    
    convenience init() {
        self.init(placesApi: PlacesApi())
    }
    
    func refreshPlaces() {
        closurePlacesWillUpdate?()
        placesApi.getPlaces(latitude: 41.0086,
                            longitude: 28.8644) { placesResponse in
            self.places = placesResponse.results.prefix(self.maximumItemCount).map { $0 }
            self.closurePlacesDidUpdate?()
        } failure: {
            //TODO: Handle failure
        }
    }
}
 
