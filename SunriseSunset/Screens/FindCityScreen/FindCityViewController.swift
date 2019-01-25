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
    
    var viewModel: FindCityViewModel? {
        didSet {
            setupViewController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.findCityTextField.delegate = self
    }
    
    
    private func findCity(text: String) {
        googlePlacecManager.findCity(text: text,
                                     onSucces: { [weak self] (result) in
                                        guard let strongSelf = self else {
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
            strongSelf.viewModel = FindCityViewModel(latitude: sunriseSunsetManager.latitude,
                                                     longitude: sunriseSunsetManager.longitude,
                                                     data: result)
            },
                                                   onFailure: { (errorMessage) in
                                                    print(errorMessage)
        })
    }
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
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
        }
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
