//
//  AppCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit


final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
//    private var currentLocationCoordinator: CurrentLocationCoordinator?
    private var listOfLocationsCoordinator: ListOfLocationsCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        window.rootViewController = rootViewController
        rootViewController.navigationBar.barTintColor = UIColor.gray
        window.makeKeyAndVisible()
    }
    
    func start(){
//        self.currentLocationCoordinator = CurrentLocationCoordinator(presenter: self.rootViewController)
//        self.currentLocationCoordinator?.start()
        self.listOfLocationsCoordinator = ListOfLocationsCoordinator(presenter: self.rootViewController)
        self.listOfLocationsCoordinator?.start()

    }
    
    
}
