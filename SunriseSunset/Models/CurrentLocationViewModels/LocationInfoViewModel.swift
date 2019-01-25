//
//  CurrentLocationVCViewModel.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation


class LocationInfoViewModel {
    let latitude: Float
    let longitude: Float
    let sunrise: String
    let sunset: String
    let solarNoon: String
    let dayLength: String
    let civilTwilightBegin: String
    let civilTwilightEnd: String
    let astronomicalTwilightBegin: String
    let astronomicalTwilightEnd: String
    
    init(latitude: Float, longitude: Float, data: SunsetSunriseInfo) {
        self.latitude = latitude
        self.longitude = longitude
        self.sunrise = data.results.sunrise.components(separatedBy: ["T", "+"])[1]
        self.sunset = data.results.sunset.components(separatedBy: ["T", "+"])[1]
        self.solarNoon = data.results.solarNoon.components(separatedBy: ["T", "+"])[1]
        self.dayLength = "\(data.results.dayLength / 3600):\((data.results.dayLength % 3600)/60):\((data.results.dayLength % 3600) % 60)"
        self.civilTwilightBegin = data.results.civilTwilightBegin.components(separatedBy: ["T", "+"])[1]
        self.civilTwilightEnd = data.results.civilTwilightEnd.components(separatedBy: ["T", "+"])[1]
        self.astronomicalTwilightBegin = data.results.astronomicalTwilightBegin.components(separatedBy: ["T", "+"])[1]
        self.astronomicalTwilightEnd = data.results.astronomicalTwilightEnd.components(separatedBy: ["T", "+"])[1]


    }
}
