//
//  CurrentLocationViewController.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController, StoryboardInstantiable {
    
    private var sunriseSunsetManager: SunriseSunsetManager?
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        self.currentLocation = requestCurrentLocation()
        guard let currentLocation = currentLocation else {
            print("Cannot find current location")
            return
        }
        let latitude = Float(currentLocation.coordinate.latitude)
        let longitude = Float(currentLocation.coordinate.longitude)
        self.sunriseSunsetManager = SunriseSunsetManager(latitude: latitude, longitude: longitude)
        
        sunriseSunsetManager?.getSunriseSunsetInfo(onSucces: { (data) in
            print(data.results.sunrise)
        }, onFailure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    
    private func requestCurrentLocation() -> CLLocation? {
        
        locationManager.requestLocation()
        return locationManager.location
    }

}

extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

