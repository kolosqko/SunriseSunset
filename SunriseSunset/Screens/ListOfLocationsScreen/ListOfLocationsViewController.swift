//
//  ListOfLocationsViewController.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit
import CoreLocation

class ListOfLocationsViewController: UIViewController, StoryboardInstantiable {
    
    var viewModel: ListOfLocationsViewModel? {
        didSet {
            locationsTableView.reloadData()
        }
    }
    private let locationManager = CLLocationManager()

    let locationCellIdentifier = "ListOfLocationsTableViewCell"
    let addLocationCellIdentifier = "AddLocationTableViewCell"

    @IBOutlet weak var locationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationsTableView()
        setupLocationManager()
    }
    
    private func setupLocationsTableView() {
        locationsTableView.dataSource = self
        let locationCellNib = UINib(nibName: locationCellIdentifier, bundle: nil)
        locationsTableView.register(locationCellNib, forCellReuseIdentifier: locationCellIdentifier)
        let addLocationCellNib = UINib(nibName: addLocationCellIdentifier, bundle: nil)
        locationsTableView.register(addLocationCellNib, forCellReuseIdentifier: addLocationCellIdentifier)
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
}


extension ListOfLocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.locations.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.tableView(tableView, numberOfRowsInSection: 0) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: addLocationCellIdentifier, for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCellIdentifier, for: indexPath)
        if let cell = cell as? ListOfLocationsTableViewCell, let viewModel = viewModel {
            cell.setupCell(locationInfo: viewModel.locations[indexPath.row])
        }
        return cell
    }
    
    
}


extension ListOfLocationsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latitude = manager.location?.coordinate.latitude,
            let longitude = manager.location?.coordinate.longitude  else {
            return
        }
        guard let viewModel = viewModel else {
            self.viewModel = ListOfLocationsViewModel(name: "Current location",
                                                 latitude: Float(latitude),
                                                 longitude: Float(longitude))
            return
        }
        viewModel.locations[0] = LocationInfo(name: "Current location",
                                              latitude: Float(latitude),
                                              longitude: Float(longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
