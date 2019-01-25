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
    private var findCityCoordinator: FindCityCoordinator?

    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let currentLocationViewController: CurrentLocationViewController = CurrentLocationViewController.instantiateViewController()
        self.presenter.pushViewController(currentLocationViewController, animated: true)
        self.currentLocationViewController = currentLocationViewController
        
        let findCityButton = UIBarButtonItem(title: "Find city", style: .plain, target: self, action: #selector(findCityTapped))
        findCityButton.tintColor = UIColor.white
        currentLocationViewController.navigationItem.rightBarButtonItems = [findCityButton]
    }
    
    @objc private func findCityTapped() {
        let findCityCoordinator = FindCityCoordinator(presenter: presenter)
        findCityCoordinator.start()
        self.findCityCoordinator = findCityCoordinator
    }
}
