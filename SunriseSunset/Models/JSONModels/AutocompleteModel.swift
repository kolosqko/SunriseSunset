//
//  AutocompleteModel.swift
//  SunriseSunset
//
//  Created by Kolos on 1/26/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation

struct AutocompleteModel: Decodable {
    let status: String
    let predictions: [Prediction]
}

struct Prediction: Decodable {
    let description: String
}
