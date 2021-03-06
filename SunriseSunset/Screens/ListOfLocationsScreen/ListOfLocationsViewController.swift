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
}


extension ListOfLocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.locations.count + 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.tableView(tableView, numberOfRowsInSection: 1) - 1,
            indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: addLocationCellIdentifier, for: indexPath)
            let backgroundView = UIView()
            backgroundView.backgroundColor = Palette.palette.contrast
            cell.selectedBackgroundView = backgroundView
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCellIdentifier, for: indexPath)
        if let cell = cell as? ListOfLocationsTableViewCell, let viewModel = viewModel {
            switch indexPath.section {
            case 0:
                cell.setupCell(locationInfo: viewModel.currentLocation ?? LocationInfo())
            case 1:
                cell.setupCell(locationInfo: viewModel.locations[indexPath.row])
            default:
                return cell
            }
        }
        let backgroundView = UIView()
        backgroundView.backgroundColor = Palette.palette.contrast
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Current location"
        case 1:
            return "Saved locations"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let tableHeader = view as? UITableViewHeaderFooterView else {
            return
        }
        tableHeader.backgroundView?.backgroundColor = Palette.palette.blanc
        tableHeader.textLabel?.textColor = Palette.palette.textMain
    }
}

extension ListOfLocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        guard let viewModel = viewModel else {
            return
        }
        switch indexPath.section {
        case 0:
            guard let currentLocation = viewModel.currentLocation else {
                return
            }
            delegate?.didSelectLocation(currentLocation)
        case 1:
            if indexPath.row == viewModel.locations.count {
                delegate?.addNewlocation()
                return
            }
            delegate?.didSelectLocation(viewModel.locations[indexPath.row])
        default:
            return
        }
    }
}

extension ListOfLocationsViewController: ListOfLocationsViewModelDelegate {
    func viewModelDidUpdate() {
        self.locationsTableView.reloadData()
    }
}
