//
//  SearchCoordinator.swift
//  SunriseSunset
//
//  Created by Kolos on 1/26/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var searchViewController: SearchViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let searchViewController: SearchViewController = SearchViewController.instantiateViewController()
        presenter.pushViewController(searchViewController, animated: true)
        self.searchViewController = searchViewController
    }
}
