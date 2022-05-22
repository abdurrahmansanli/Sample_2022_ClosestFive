//
//  PlacesApi.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 22.05.2022.
//

final class PlacesApi {
    
    func getPlaces() {
        ApiClient().sendRequest(httpMethod: .get,
                                responseType: PlacesResponse.self,
                                urlString: "places/nearby?ll=41.00867687083824%2C28.864482240736038") { response in
            
        } failure: {
            
        }
    }
}
