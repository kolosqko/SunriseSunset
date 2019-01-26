//
//  GooglePlaceInfo.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation

struct GooglePlaceInfo: Decodable {
    let results: [Result]
    let status: String
}

struct Result: Decodable {
    let geometry: Geometry
}

struct Geometry: Decodable{
    let location: Location
}
struct Location: Decodable, Encodable{
    let lat: Double
    let lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}
