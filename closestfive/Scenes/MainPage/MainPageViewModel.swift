//
//  MainPageViewModel.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

final class MainPageViewModel {
    
    let placesApi: PlacesApi
    
    init(placesApi: PlacesApi) {
        self.placesApi = placesApi
    }
    
    convenience init() {
        self.init(placesApi: PlacesApi())
    }
    
    func getPlaces() {
        placesApi.getPlaces(latitude: 41.0086,
                            longitude: 28.8644) { placesResponse in
            print("")
        } failure: {
            //TODO: Handle failure
        }
    }
}
