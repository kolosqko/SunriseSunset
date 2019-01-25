//
//  ListOfLocationsTableViewCell.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit

class ListOfLocationsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    
    func setupCell(locationInfo: LocationInfo) {
        locationNameLabel.text = locationInfo.locationName
        latitudeLabel.text = "latitude: \(locationInfo.latitude)"
        longitudeLabel.text = "longitude: \(locationInfo.longitude)"
    }
    
}
