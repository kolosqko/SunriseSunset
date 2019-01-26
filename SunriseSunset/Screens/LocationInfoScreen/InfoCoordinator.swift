//
//  InfoCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/26/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

class InfoCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var infoViewController: InfoViewController?
    private let locationInfo: LocationInfo
    
    init(presenter: UINavigationController, locationInfo: LocationInfo) {
        self.presenter = presenter
        self.locationInfo = locationInfo
    }
    
    func start() {
        let infoViewController: InfoViewController = InfoViewController.instantiateViewController()
        presenter.pushViewController(infoViewController, animated: true)
        self.infoViewController = infoViewController
    }
}
