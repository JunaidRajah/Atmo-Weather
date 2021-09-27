//
//  SearchViewModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/26.
//

import Foundation
import MapKit

final class SearchViewModel {
    private let defaults = UserDefaults.standard
    private var cityLat = [Double]()
    private var cityLon = [Double]()
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    var searchCount: Int {
        searchResults.count
    }
    
    func searchTitle(at index: Int) -> String {
        let searchResult = searchResults[index]
        return searchResult.title
    }
    
    func searchSubTitle(at index: Int) -> String {
        let searchResult = searchResults[index]
        return searchResult.subtitle
    }
    
    func searchResult(at index: Int) -> MKLocalSearchCompletion {
        searchResults[index]
    }
    
    func queryFragment(with searchText: String) {
        searchCompleter.queryFragment = searchText
    }
    
    func completerDidUpdateResults(results: [MKLocalSearchCompletion]) {
        searchResults = results
    }
    func selectedCity(at index: Int) {
        let result = searchResults[index]
        let searchRequest = MKLocalSearch.Request(completion: result)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, _) in
            let mapItems = response?.mapItems[0]
            guard let coordinate = mapItems?.placemark.coordinate else {
                return
            }
            guard (mapItems?.name) != nil else {
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
    }
}
