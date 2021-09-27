//
//  SearchViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/04.
//

import UIKit
import MapKit

final class SearchViewController: UIViewController, UISearchBarDelegate, MKLocalSearchCompleterDelegate, Storyboarded {
    
    var coordinator: MainCoordinator?
    private let searchViewModel = SearchViewModel()
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchResultsTable: UITableView!
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "clearNight.jpg") ?? UIImage())
        searchCompleter.delegate = self
        searchBar?.delegate = self
        searchResultsTable?.delegate = self
        searchResultsTable?.dataSource = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchViewModel.completerDidUpdateResults(results: completer.results)
        searchResultsTable.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - UITableView DataSource functions

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.searchCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchViewModel.searchTitle(at: indexPath.row)
        cell.detailTextLabel?.text = searchViewModel.searchSubTitle(at: indexPath.row)
        return cell
    }
}

// MARK: - UITableView Delegate functions

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchViewModel.selectedCity(at: indexPath.row)
        coordinator?.enteredNewCity(vc: self)
    }
}
