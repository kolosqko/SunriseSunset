//
//  ListOfLocationsViewController.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit

protocol ListOfLocationsViewControllerDelegate {
    func didSelectLocation(_ location: LocationInfo)
    func addNewlocation()
}

class ListOfLocationsViewController: UIViewController, StoryboardInstantiable {
    
    var viewModel: ListOfLocationsViewModel?
    var delegate: ListOfLocationsViewControllerDelegate?
    
    let locationCellIdentifier = "ListOfLocationsTableViewCell"
    let addLocationCellIdentifier = "AddLocationTableViewCell"

    @IBOutlet weak var locationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationsTableView()
        viewModel = ListOfLocationsViewModel()
        viewModel?.delegate = self
    }
    
    private func setupLocationsTableView() {
        locationsTableView.dataSource = self
        locationsTableView.delegate = self
        let locationCellNib = UINib(nibName: locationCellIdentifier, bundle: nil)
        locationsTableView.register(locationCellNib, forCellReuseIdentifier: locationCellIdentifier)
        let addLocationCellNib = UINib(nibName: addLocationCellIdentifier, bundle: nil)
        locationsTableView.register(addLocationCellNib, forCellReuseIdentifier: addLocationCellIdentifier)
    }
    
    @IBOutlet weak var currentLocationNameLabel: UILabel!
    
    
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

extension ListOfLocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        if indexPath.row == viewModel.locations.count {
            delegate?.addNewlocation()
            return
        }
        delegate?.didSelectLocation(viewModel.locations[indexPath.row])
    }
}

extension ListOfLocationsViewController: ListOfLocationsViewModelDelegate {
    func viewModelDidUpdate() {
        DispatchQueue.main.async {
            self.currentLocationNameLabel.text = "Current location: \(self.viewModel?.currentLocation)"
        }
        self.locationsTableView.reloadData()
    }
}
