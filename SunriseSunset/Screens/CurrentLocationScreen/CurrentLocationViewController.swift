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
    
    var viewModel: CurrentLocationVCViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        sunriseSunsetManager?.getSunriseSunsetInfo(onSucces: { [weak self] (data) in
            print(data.results.sunrise)
            guard let strongSelf = self else {
                return
            }
            strongSelf.instantiateViewModel(data: data)
            strongSelf.setupViewController()
        }, onFailure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    private func setupLocationManager() {
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
    }
    
    // view related --------------------------------------------------
    
    private func instantiateViewModel(data: SunsetSunriseInfo) {
        guard let latitude = self.currentLocation?.coordinate.latitude,
            let longitude = self.locationManager.location?.coordinate.longitude else {
                return
                
        }
        viewModel = CurrentLocationVCViewModel(latitude: Float(latitude),
                                               longitude: Float(longitude),
                                               data: data)
    }
    
    private func setupViewController() {
        guard let viewModel = viewModel else {
            return
        }
        
        DispatchQueue.main.async {
            self.latitudeLabel.text = String(viewModel.latitude)
            self.longitudeLabel.text = String(viewModel.longitude)
            self.sunriseLabel.text = String(viewModel.sunrise)
            self.sunsetLabel.text = String(viewModel.sunset)
        }
    }
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    
    
    
}




extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

