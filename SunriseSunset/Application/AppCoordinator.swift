//
//  AppCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorDelegate {
    func findCurrentLocation()
}


final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var listOfLocationsCoordinator: ListOfLocationsCoordinator?
    
    var delegate: AppCoordinatorDelegate?
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        UINavigationBar.appearance().barTintColor = Palette.palette.contrast
        UINavigationBar.appearance().tintColor = Palette.palette.tint
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : Palette.palette.textMain]
        UITableView.appearance().backgroundColor = Palette.palette.background
        UITableViewCell.appearance().backgroundColor = Palette.palette.background
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.largeTitleTextAttributes = [.foregroundColor : Palette.palette.textMain]
    }
    
    func start(){
        
        let listOfLocationsCoordinator = ListOfLocationsCoordinator(presenter: self.rootViewController)
        listOfLocationsCoordinator.delegate = self
        listOfLocationsCoordinator.start()
        self.listOfLocationsCoordinator = listOfLocationsCoordinator

    }
    
    
}


extension AppCoordinator: ListOfLocationsCoordinatorDelegate {
    func currentLocationButtonTapped() {
        delegate?.findCurrentLocation()
    }
}
