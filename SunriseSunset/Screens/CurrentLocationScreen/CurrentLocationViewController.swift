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
        locationManager.requestLocation()
        self.currentLocation = locationManager.location
        guard let currentLocation = currentLocation else {
            print("Cannot find current location")
            return
        }
        let latitude = Float(currentLocation.coordinate.latitude)
        let longitude = Float(currentLocation.coordinate.longitude)
        self.sunriseSunsetManager = SunriseSunsetManager(latitude: latitude, longitude: longitude)
        
        sunriseSunsetManager?.getSunriseSunsetInfo(onSucces: { [weak self] (data) in
            print(data.results.sunrise)
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.setupViewController()
            }
        }, onFailure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    // view realted --------------------------------------------------
    
    private func setupViewController() {
        guard let latitude = currentLocation?.coordinate.latitude,
            let longitude = locationManager.location?.coordinate.longitude else {
                return
        }
        self.latitudeLabel.text = String(latitude)
        self.longitudeLabel.text = String(longitude)
    }
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
}




extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

