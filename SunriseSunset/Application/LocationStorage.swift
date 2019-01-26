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
    
    private(set) var locations: [Location]
    private let fileManager: FileManager
    private let documentsURL: URL
    private let geoCoder = CLGeocoder()
    
    init() {
        let fileManager = FileManager.default
        documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.fileManager = fileManager

        let jsonDecoder = JSONDecoder()
        
        let locationsURL = documentsURL.appendingPathComponent("LocationsStorage")

        guard let data = try? Data(contentsOf: locationsURL) else {
            self.locations = []
            return
        }
        
        guard let locations = try? jsonDecoder.decode([Location].self, from: data) else {
            self.locations = []
            return
        }
        self.locations = locations
    }
    
    func saveLocationOnDisk(_ location: Location) {
        let encoder = JSONEncoder()
        let fileURL = documentsURL.appendingPathComponent("LocationsStorage")
        
        var locations = self.locations
        locations.append(location)
        getLocationDescription(location)
        let data = try! encoder.encode(locations)
        try! data.write(to: fileURL)

        self.locations = locations

    }
    
    private func getLocationDescription(_ location: Location) {
        let cllocation = CLLocation(latitude: location.lat, longitude: location.lng)
        geoCoder.reverseGeocodeLocation(cllocation) { placemarks, _ in
            if let place = placemarks?.first {
                let description = "\(place)"
                print(place.locality)
                print(place.country)
                print(place.timeZone?.identifier)

            }
            
        }
    }
    
}
