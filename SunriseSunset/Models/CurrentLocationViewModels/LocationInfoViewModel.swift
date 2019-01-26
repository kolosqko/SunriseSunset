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
        self.sunrise = LocationInfoViewModel.timeInRightTimeZone(data.results.sunrise, timeZoneId: locationInfo.timeZoneId)
        self.sunset = LocationInfoViewModel.timeInRightTimeZone(data.results.sunset, timeZoneId: locationInfo.timeZoneId)
        self.solarNoon = LocationInfoViewModel.timeInRightTimeZone(data.results.solarNoon, timeZoneId: locationInfo.timeZoneId)
        self.dayLength = "\(data.results.dayLength / 3600):\((data.results.dayLength % 3600)/60):\((data.results.dayLength % 3600) % 60)"
        self.civilTwilightBegin = LocationInfoViewModel.timeInRightTimeZone(data.results.civilTwilightBegin, timeZoneId: locationInfo.timeZoneId)
        self.civilTwilightEnd = LocationInfoViewModel.timeInRightTimeZone(data.results.civilTwilightEnd, timeZoneId: locationInfo.timeZoneId)
        self.astronomicalTwilightBegin = LocationInfoViewModel.timeInRightTimeZone(data.results.astronomicalTwilightBegin, timeZoneId: locationInfo.timeZoneId)
        self.astronomicalTwilightEnd = LocationInfoViewModel.timeInRightTimeZone(data.results.astronomicalTwilightEnd, timeZoneId: locationInfo.timeZoneId)
    }
    
    private static func timeInRightTimeZone(_ dateString: String, timeZoneId: String) -> String {
        guard let date = dateString.toDate() else {
            return dateString
        }
        guard let timeZone = TimeZone(identifier: timeZoneId) else {
            return dateString
        }
        let timeDifference = timeZone.secondsFromGMT()
        return date.addingTimeInterval(Double(timeDifference)).toString()
    }
}
