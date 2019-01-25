//
//  FindCityCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

class FindCityCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var findCityViewController: FindCityViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let findCityViewController: FindCityViewController = FindCityViewController.instantiateViewController()
        presenter.pushViewController(findCityViewController, animated: true)
        self.findCityViewController = findCityViewController
        presenter.navigationBar.tintColor = UIColor.white
    }
}
