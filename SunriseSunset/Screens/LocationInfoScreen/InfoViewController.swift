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
    
    override func viewDidLoad() {
        setupColors()
    }
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
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
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    private func setupViewController() {
        guard let viewModel = viewModel else {
            return
        }
        
        DispatchQueue.main.async {
            self.locationNameLabel.adjustsFontSizeToFitWidth = true
            self.timeZoneLabel.adjustsFontSizeToFitWidth = true
            self.locationNameLabel.text = viewModel.locationName
            self.timeZoneLabel.text = "Time in local time zone (\(viewModel.timeZoneId))"
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
    
    private func setupColors() {
        titleView.backgroundColor = Palette.palette.background
        infoView.backgroundColor = Palette.palette.background
        locationNameLabel.textColor = Palette.palette.textMain
        timeZoneLabel.textColor = Palette.palette.textMain
        latitudeLabel.textColor = Palette.palette.textMain
        longitudeLabel.textColor = Palette.palette.textMain
        sunriseLabel.textColor = Palette.palette.textMain
        sunsetLabel.textColor = Palette.palette.textMain
        solarNoonLabel.textColor = Palette.palette.textMain
        dayLengthLabel.textColor = Palette.palette.textMain
        civilTwilightBeginLabel.textColor = Palette.palette.textMain
        civilTwilightEndLabel.textColor = Palette.palette.textMain
        astronomicalTwilightBeginLabel.textColor = Palette.palette.textMain
        astronomicalTwilightEndLabel.textColor = Palette.palette.textMain

        unchanchebleLatitudeLabel.textColor = Palette.palette.textMain
        unchanchebleLongitudeLabel.textColor = Palette.palette.textMain
        unchanchebleSRLabel.textColor = Palette.palette.textMain
        unchanchebleSSLabel.textColor = Palette.palette.textMain
        unchanchebleSNLabel.textColor = Palette.palette.textMain
        unchanchebleDLLabel.textColor = Palette.palette.textMain
        unchanchebleCTBLabel.textColor = Palette.palette.textMain
        unchanchebleCTELabel.textColor = Palette.palette.textMain
        unchanchebleATBLabel.textColor = Palette.palette.textMain
        unchanchebleATELabel.textColor = Palette.palette.textMain
    }
    
    // Unchangeble labels:
    
    @IBOutlet weak var unchanchebleLatitudeLabel: UILabel!
    @IBOutlet weak var unchanchebleLongitudeLabel: UILabel!
    @IBOutlet weak var unchanchebleSRLabel: UILabel!
    @IBOutlet weak var unchanchebleSSLabel: UILabel!
    @IBOutlet weak var unchanchebleSNLabel: UILabel!
    @IBOutlet weak var unchanchebleDLLabel: UILabel!
    @IBOutlet weak var unchanchebleCTBLabel: UILabel!
    @IBOutlet weak var unchanchebleCTELabel: UILabel!
    @IBOutlet weak var unchanchebleATBLabel: UILabel!
    @IBOutlet weak var unchanchebleATELabel: UILabel!
    
    
    
    
}
