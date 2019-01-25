//
//  ListOfLocationsViewModel.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation

class ListOfLocationsViewModel {
    var locations: [LocationInfo]
    
    init(name: String, latitude: Float, longitude: Float) {
        self.locations = [LocationInfo(name: name, latitude: latitude, longitude: longitude)]
    }
}

struct LocationInfo {
    
    let locationName: String
    let latitude: Float
    let longitude: Float
    
    init(name: String, latitude: Float, longitude: Float) {
        self.locationName = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
