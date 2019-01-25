//
//  CurrentLocationVCViewModel.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation


class CurrentLocationVCViewModel {
    let latitude: Float
    let longitude: Float
    let sunrise: String
    let sunset: String
    
    init(latitude: Float, longitude: Float, data: SunsetSunriseInfo) {
        self.latitude = latitude
        self.longitude = longitude
        self.sunrise = data.results.sunrise.components(separatedBy: ["T", "+"])[1]
        self.sunset = data.results.sunset.components(separatedBy: ["T", "+"])[1]
    }
}
