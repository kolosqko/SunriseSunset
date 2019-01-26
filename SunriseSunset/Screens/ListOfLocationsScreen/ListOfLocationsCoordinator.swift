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
    private var infoCoordinator: InfoCoordinator?
    private var searchCoordinator: SearchCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let listOfLocationsViewController: ListOfLocationsViewController = ListOfLocationsViewController.instantiateViewController()
        listOfLocationsViewController.delegate = self
        presenter.pushViewController(listOfLocationsViewController, animated: true)
        self.listOfLocationsViewController = listOfLocationsViewController
    }
}

extension ListOfLocationsCoordinator: ListOfLocationsViewControllerDelegate{
    func didSelectLocation(_ location: LocationInfo) {
        let infoCoordinator = InfoCoordinator(presenter: presenter, locationInfo: location)
        infoCoordinator.start()
        self.infoCoordinator = infoCoordinator
    }
    
    func addNewlocation() {
        let searchCoordinator = SearchCoordinator(presenter: presenter)
        searchCoordinator.start()
        self.searchCoordinator = searchCoordinator
    }
}
