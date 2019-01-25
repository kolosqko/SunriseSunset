//
//  CurrentLocationViewController.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit

class CurrentLocationViewController: UIViewController, StoryboardInstantiable {
    
    private let sunriseSunsetManager = SunriseSunsetManager(latitude: 1, longitude: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        sunriseSunsetManager.getSunriseSunsetInfo(onSucces: { (data) in
            print(data.results.dayLength)
        },
                                                  onFailure: { (errorMessage) in
                                                    print(errorMessage)
        })
    }

}
