//
//  Place.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 22.05.2022.
//

final class PlacesResponse: Decodable {
    var results: [Place]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

final class Place: Decodable {
    var name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
