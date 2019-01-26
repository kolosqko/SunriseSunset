//
//  ListOfLocationsViewModel.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation

protocol ListOfLocationsViewModelDelegate {
    func viewModelDidUpdate()
}

class ListOfLocationsViewModel {
    var locations: [LocationInfo] {
        didSet {
            delegate?.viewModelDidUpdate()
        }
    }
    
    var delegate: ListOfLocationsViewModelDelegate?
    
    init(name: String, latitude: Float, longitude: Float) {
        self.locations = [LocationInfo(name: name, latitude: latitude, longitude: longitude, timeZoneId: "Europe/Kiev")]
    }
    
    init() {
        self.locations = LocationsStorage.shared.locations
        LocationsStorage.shared.delegate = self
    }
}

struct LocationInfo: Decodable, Encodable {
    
    let locationName: String
    let latitude: Float
    let longitude: Float
    let timeZoneId: String
    
    init(name: String, latitude: Float, longitude: Float, timeZoneId: String) {
        self.locationName = name
        self.latitude = latitude
        self.longitude = longitude
        self.timeZoneId = timeZoneId
    }
}

extension ListOfLocationsViewModel: LocationStorageDelegateProtocol {
    func locationsDidUpdate() {
        self.locations = LocationsStorage.shared.locations
    }
}
