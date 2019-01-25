//
//  CurrentLocationCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

class CurrentLocationCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var currentLocationViewController: CurrentLocationViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let currentLocationViewController: CurrentLocationViewController = CurrentLocationViewController.instantiateViewController()
        self.presenter.pushViewController(currentLocationViewController, animated: true)
        self.currentLocationViewController = currentLocationViewController
    }
}
