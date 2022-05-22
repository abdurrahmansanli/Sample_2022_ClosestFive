//
//  PlacesApi.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 22.05.2022.
//

final class PlacesApi {
    
    func getPlaces(latitude: Double,
                   longitude: Double,
                   success: @escaping (PlacesResponse) -> Void,
                   failure: @escaping () -> Void) {
        ApiClient().sendRequest(httpMethod: .get,
                                responseType: PlacesResponse.self,
                                urlString: "places/nearby?ll=\(latitude)%2C\(longitude)",
                                success: success,
                                failure: failure)
    }
}
