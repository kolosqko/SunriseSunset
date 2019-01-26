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
    private let sunriseSunsetManager: SunriseSunsetManager
    
    init(presenter: UINavigationController, locationInfo: LocationInfo) {
        self.presenter = presenter
        self.locationInfo = locationInfo
        self.sunriseSunsetManager = SunriseSunsetManager(latitude: locationInfo.latitude,
                                                         longitude: locationInfo.longitude)
    }
    
    func start() {
        let infoViewController: InfoViewController = InfoViewController.instantiateViewController()
        presenter.pushViewController(infoViewController, animated: true)
        self.infoViewController = infoViewController
        setupViewModel()
    }
    
    private func setupViewModel() {
        sunriseSunsetManager.getSunriseSunsetInfo(onSucces: { [weak self] (data) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.infoViewController?.viewModel = LocationInfoViewModel(locationInfo: strongSelf.locationInfo, data: data)

            }, onFailure: { [weak self] (errorMessage) in
                self?.infoViewController?.showErrorAlert(errorMessage: errorMessage)
        })
    }
}
