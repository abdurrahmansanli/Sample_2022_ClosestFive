//
//  Place.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 22.05.2022.
//

import Foundation

final class PlacesResponse: NSObject, Codable {
    var results: [Place]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

final class Place: NSObject, Codable {
    var name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
