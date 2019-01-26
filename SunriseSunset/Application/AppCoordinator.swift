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
    private var listOfLocationsCoordinator: ListOfLocationsCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        UINavigationBar.appearance().barTintColor = UIColor.gray
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        
    }
    
    func start(){

        self.listOfLocationsCoordinator = ListOfLocationsCoordinator(presenter: self.rootViewController)
        self.listOfLocationsCoordinator?.start()

    }
    
    
}
