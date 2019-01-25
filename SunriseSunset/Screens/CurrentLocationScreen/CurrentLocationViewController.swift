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
    
    var viewModel: LocationInfoViewModel?

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
        viewModel = LocationInfoViewModel(latitude: Float(latitude),
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
            self.solarNoonLabel.text = String(viewModel.solarNoon)
            self.dayLengthLabel.text = String(viewModel.dayLength)
            self.civilTwilightBeginLabel.text = String(viewModel.civilTwilightBegin)
            self.civilTwilightEndLabel.text = String(viewModel.civilTwilightEnd)
            self.astronomicalTwilightBeginLabel.text = String(viewModel.astronomicalTwilightBegin)
            self.astronomicalTwilightEndLabel.text = String(viewModel.astronomicalTwilightEnd)
        }
    }
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var solarNoonLabel: UILabel!
    @IBOutlet weak var dayLengthLabel: UILabel!
    @IBOutlet weak var civilTwilightBeginLabel: UILabel!
    @IBOutlet weak var civilTwilightEndLabel: UILabel!
    @IBOutlet weak var astronomicalTwilightBeginLabel: UILabel!
    @IBOutlet weak var astronomicalTwilightEndLabel: UILabel!
    
}




extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

