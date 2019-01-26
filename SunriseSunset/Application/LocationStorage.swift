//
//  LocationStorage.swift
//  SunriseSunset
//
//  Created by Kolos on 1/26/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import CoreLocation

class LocationsStorage {
    static let shared = LocationsStorage()
    
    private(set) var locations: [LocationInfo]
    private let fileManager: FileManager
    private let documentsURL: URL
    private let geoCoder = CLGeocoder()
    
    var delegate: LocationStorageDelegateProtocol?
    
    init() {
        let fileManager = FileManager.default
        documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.fileManager = fileManager

        let jsonDecoder = JSONDecoder()
        
        let locationsURL = documentsURL.appendingPathComponent("Storage")

        guard let data = try? Data(contentsOf: locationsURL) else {
            self.locations = []
            return
        }
        
        guard let locations = try? jsonDecoder.decode([LocationInfo].self, from: data) else {
            self.locations = []
            return
        }
        self.locations = locations
    }
    
    private func saveLocationOnDisk(_ location: LocationInfo) {
        let encoder = JSONEncoder()
        let fileURL = documentsURL.appendingPathComponent("Storage")
        
        
        var locations = self.locations
        if isLocationInfoSaved(location) {
            return
        }
        
        locations.append(location)
        let data = try! encoder.encode(locations)
        try! data.write(to: fileURL)

        self.locations = locations
        delegate?.locationsDidUpdate()
    }
    
    func saveLocation(_ location: Location){
        let cllocation = CLLocation(latitude: location.lat, longitude: location.lng)
        geoCoder.reverseGeocodeLocation(cllocation) { placemarks, _ in
            guard let place = placemarks?.first else {
                return
            }
            guard let cityName = place.locality,
                let country = place.country,
                let timeZoneId = place.timeZone?.identifier else {
                return
            }
            let locationInfo = LocationInfo(name: cityName + " " + country,
                                            latitude: Float(location.lat),
                                            longitude: Float(location.lng),
                                            timeZoneId: timeZoneId)
            self.saveLocationOnDisk(locationInfo)
        }
    }
    
    private func isLocationInfoSaved(_ locationInfo: LocationInfo) -> Bool{
        var isSaved = false
        self.locations.forEach{ location in
            if location.locationName == locationInfo.locationName {
                isSaved = true
            }
        }
        return isSaved
    }
    
    
}


protocol LocationStorageDelegateProtocol {
    func locationsDidUpdate()
}

