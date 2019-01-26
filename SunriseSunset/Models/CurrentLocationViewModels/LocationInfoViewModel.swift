//
//  CurrentLocationVCViewModel.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation


class LocationInfoViewModel {
    let locationName: String
    let timeZoneId: String
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
    
    init(locationInfo: LocationInfo, data: SunsetSunriseInfo) {
        self.locationName = locationInfo.locationName
        self.timeZoneId = locationInfo.timeZoneId
        self.latitude = locationInfo.latitude
        self.longitude = locationInfo.longitude
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
