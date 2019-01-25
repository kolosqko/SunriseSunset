//
//  ListOfLocationsCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

class ListOfLocationsCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var listOfLocationsViewController: ListOfLocationsViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let listOfLocationsViewController: ListOfLocationsViewController = ListOfLocationsViewController.instantiateViewController()
        presenter.pushViewController(listOfLocationsViewController, animated: true)
        self.listOfLocationsViewController = listOfLocationsViewController
    }
}
