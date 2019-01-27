//
//  LocationStorage.swift
//  SunriseSunset
//
//  Created by Kolos on 1/26/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationStorageDelegateProtocol {
    func locationsDidUpdate()
}

class LocationsStorage {
    static let shared = LocationsStorage()
    
    private(set) var locations: [LocationInfo]
    private(set) var currentLocation: LocationInfo?
    private let fileManager: FileManager
    private let documentsURL: URL
    private let geoCoder = CLGeocoder()
    
    private static let storageFileName = "Storage"
    
    var delegate: LocationStorageDelegateProtocol?
    
    init() {
        let fileManager = FileManager.default
        documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.fileManager = fileManager

        let jsonDecoder = JSONDecoder()
        
        let locationsURL = documentsURL.appendingPathComponent(LocationsStorage.storageFileName)

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
    
    private func saveLocationOnDisk(_ location: LocationInfo, isCurrentLocation: Bool = false) {
        let encoder = JSONEncoder()
        let fileURL = documentsURL.appendingPathComponent(LocationsStorage.storageFileName)
        
        
        var locations = self.locations
        
        if isLocationInfoSaved(location), isCurrentLocation {
            delegate?.locationsDidUpdate()
            return
        }
        
        locations.append(location)
        let data = try! encoder.encode(locations)
        try! data.write(to: fileURL)

        self.locations = locations
        delegate?.locationsDidUpdate()
    }
    
    func saveLocation(_ location: Location, isCurrentLocation: Bool = false){
        let cllocation = CLLocation(latitude: location.lat, longitude: location.lng)
        geoCoder.reverseGeocodeLocation(cllocation) { placemarks, _ in
            guard let place = placemarks?.first else {
                return
            }
            let cityName = place.locality ?? "Nil"
            let adminArea = place.administrativeArea ?? "Nil"
            let country = place.country ?? "Nil"
            let timeZoneId = place.timeZone?.identifier ?? "Europe/London"
            let locationInfo = LocationInfo(name: cityName + ", " + adminArea + ", " + country,
                                            latitude: Float(location.lat),
                                            longitude: Float(location.lng),
                                            timeZoneId: timeZoneId)
            if isCurrentLocation {
                self.currentLocation = locationInfo
                self.delegate?.locationsDidUpdate()
            }
            self.saveLocationOnDisk(locationInfo, isCurrentLocation: isCurrentLocation)
        }
    }
    
    func removelocation(locationName: String) {
        var locations = self.locations
        for index in 0...locations.count {
            if locations[index].locationName == locationName {
                locations.remove(at: index)
            }
        }
        
        let encoder = JSONEncoder()
        let fileURL = documentsURL.appendingPathComponent(LocationsStorage.storageFileName)
        
        let data = try! encoder.encode(locations)
        try! data.write(to: fileURL)
        
        self.locations = locations
        delegate?.locationsDidUpdate()
        
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




