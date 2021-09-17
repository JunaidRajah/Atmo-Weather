//
//  SearchViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/04.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, UISearchBarDelegate, MKLocalSearchCompleterDelegate {

    private let defaults = UserDefaults.standard
    private var cityLat = [Double]()
    private var cityLon = [Double]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTable: UITableView!
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()

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
        searchResults = completer.results
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
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let searchResult = searchResults[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

    // MARK: - UITableView Delegate functions

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, _) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            guard (response?.mapItems[0].name) != nil else {
                return
            }
            
            let lat = coordinate.latitude
            let lon = coordinate.longitude
            
            if let lati = self.defaults.array(forKey: "cityLat") as? [Double] {
                self.cityLat = lati
                self.cityLat.append(lat)
            } else {
                self.cityLat.append(lat)
            }
            
            self.defaults.set(self.cityLat, forKey: "cityLat")
            
            if let loni = self.defaults.array(forKey: "cityLon") as? [Double] {
                self.cityLon = loni
                self.cityLon.append(lon)
            } else {
                self.cityLon.append(lon)
            }
            
            self.defaults.set(self.cityLon, forKey: "cityLon")
        }
        performSegue(withIdentifier: "returnFromCity", sender: self)
    }
}
