//
//  AppDelegate.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    private let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        setupLocationManager()
        self.appCoordinator = AppCoordinator(window: self.window!)
        self.appCoordinator?.start()
        return true
    }
    
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
    }

}


extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latitude = manager.location?.coordinate.latitude,
            let longitude = manager.location?.coordinate.longitude  else {
                return
        }
        let location = Location(lat: latitude, lng: longitude)
        LocationsStorage.shared.saveLocation(location, isCurrentLocation: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

