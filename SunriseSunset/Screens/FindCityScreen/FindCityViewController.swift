//
//  FindCityViewController.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit

class FindCityViewController: UIViewController, StoryboardInstantiable {
    
    private var sunriseSunsetManager: SunriseSunsetManager? {
        didSet {
            setupViewModel()
        }
    }
    private var googlePlacecManager = GooglePlacesManager()
    
    var viewModel: LocationInfoViewModel? {
        didSet {
            setupViewController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.findCityTextField.delegate = self
        googlePlacecManager.getTimeZone(latitude: 10, longitude: 10, onSucces: { (result) in
            print(result.timeZoneId)
        }, onFailure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    
    private func findCity(text: String) {
        googlePlacecManager.findCity(text: text,
                                     onSucces: { [weak self] (result) in
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        if result.status != "OK" {
                                            strongSelf.showErrorAlert(errorMessage: result.status)
                                            return
                                        }
                                        let latitude = Float(result.results[0].geometry.location.lat)
                                        let longitude = Float(result.results[0].geometry.location.lng)
                                        strongSelf.sunriseSunsetManager = SunriseSunsetManager(latitude: latitude, longitude: longitude)
            },
                                     onFailure: { (errorMessage) in
                                        print(errorMessage)
        })
    }
    
    private func setupViewModel() {
        sunriseSunsetManager?.getSunriseSunsetInfo(onSucces: { [weak self] (result) in
            guard let strongSelf = self, let sunriseSunsetManager = self?.sunriseSunsetManager else {
                return
            }
//            strongSelf.viewModel = LocationInfoViewModel(latitude: sunriseSunsetManager.latitude,
//                                                     longitude: sunriseSunsetManager.longitude,
//                                                     data: result)
            },
                                                   onFailure: { [weak self] (errorMessage) in
                                                    guard let strongSelf = self else {
                                                        return
                                                    }
                                                    strongSelf.showErrorAlert(errorMessage: errorMessage)
        })
    }
    
    private func showErrorAlert(errorMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
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
    
    @IBOutlet weak var findCityTextField: UITextField!
    
    private func setupViewController() {
        guard let viewModel = viewModel else {
            return
        }
        
        DispatchQueue.main.async {
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}


extension FindCityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        textField.text = ""
        findCity(text: text)
        return true
    }
    
}
