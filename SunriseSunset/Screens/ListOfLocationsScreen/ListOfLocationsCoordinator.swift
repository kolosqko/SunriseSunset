//
//  ListOfLocationsCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

protocol ListOfLocationsCoordinatorDelegate {
    func currentLocationButtonTapped()
}

class ListOfLocationsCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var listOfLocationsViewController: ListOfLocationsViewController?
    private var infoCoordinator: InfoCoordinator?
    private var searchCoordinator: SearchCoordinator?
    
    var delegate: ListOfLocationsCoordinatorDelegate?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let listOfLocationsViewController: ListOfLocationsViewController = ListOfLocationsViewController.instantiateViewController()
        listOfLocationsViewController.delegate = self
        listOfLocationsViewController.navigationItem.title = "Saved locations"
        presenter.pushViewController(listOfLocationsViewController, animated: true)
        let currentLocationButton = UIBarButtonItem(title: "Find current location", style: .plain, target: self, action: #selector(currentLocationButtonTapped))
        listOfLocationsViewController.navigationItem.rightBarButtonItems = [currentLocationButton]
        self.listOfLocationsViewController = listOfLocationsViewController
    }
    
    @objc private func currentLocationButtonTapped() {
        delegate?.currentLocationButtonTapped()
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
