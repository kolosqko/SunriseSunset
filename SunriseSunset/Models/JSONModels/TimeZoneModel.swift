//
//  TimeZoneModel.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation

struct TimeZoneModel: Decodable {
    let dstOffset: Int
    let rawOffset: Int
    let status: String
    let timeZoneId: String
    let timeZoneName: String
    
}
