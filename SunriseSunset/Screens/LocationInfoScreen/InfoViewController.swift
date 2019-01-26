//
//  InfoViewController.swift
//  SunriseSunset
//
//  Created by Kolos on 1/26/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, StoryboardInstantiable {
    
    var viewModel: LocationInfoViewModel? {
        didSet {
            setupViewController()
        }
    }
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
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
    
    private func setupViewController() {
        guard let viewModel = viewModel else {
            return
        }
        
        DispatchQueue.main.async {
            self.locationNameLabel.text = viewModel.locationName
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
    
}
