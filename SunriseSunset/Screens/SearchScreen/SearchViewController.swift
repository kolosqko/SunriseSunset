//
//  SearchViewController.swift
//  SunriseSunset
//
//  Created by Kolos on 1/26/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, StoryboardInstantiable {
    
    private var result = [Prediction]()
    private let googleManager = GooglePlacesManager()

    @IBOutlet weak var resultsTableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterPossibleResults(_ searchText: String, scope: String = "All") {
        googleManager.autocomplete(text: searchText, onSucces: { [weak self] result in
            self?.result = result.predictions
            DispatchQueue.main.async {
                self?.resultsTableView.reloadData()
            }
        }, onFailure: { errorMessage in
            print(errorMessage)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if searchBarIsEmpty() {
            return
        }
        filterPossibleResults(text)
    }
    
    
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "default")
        cell.textLabel?.text = result[indexPath.row].description
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
