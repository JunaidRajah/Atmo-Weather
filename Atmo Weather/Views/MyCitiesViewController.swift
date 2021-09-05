//
//  MyCitiesViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/05.
//

import UIKit
import CoreLocation

class MyCitiesViewController: UIViewController {

    @IBOutlet weak var cityTableView: UITableView!
    let locales = LocalLocales.locales
    var name = "The Middle of Nowhere"
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.register(MyCitiesTableViewCell.nib(), forCellReuseIdentifier: MyCitiesTableViewCell.identifier)
        cityTableView?.delegate = self
        cityTableView?.dataSource = self
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String {

        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")

        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                return placemark.locality ?? "A place with no name"
            } else {
                return "Unknown"
            }
        }
        return "Unknown"
    }
}
extension MyCitiesViewController: UITableViewDataSource {
    // This method declares the number of sections that we want in our table.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // This method declares how many rows are the in the table
    // We want this to be the number of current search results that the
    // Completer has generated for us
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locales.cities.count - 1
    }
    
    // This method delcares the cells that are table is going to show at a particular index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the specific searchResult at the particular index
        let cityCell = tableView.dequeueReusableCell(withIdentifier: MyCitiesTableViewCell.identifier, for: indexPath) as! MyCitiesTableViewCell
        
        cityCell.configure(lat: self.locales.cities[indexPath.row + 1].lat,
                           lon: self.locales.cities[indexPath.row + 1].lon,
                           cellBack: self.locales.cities[indexPath.row + 1].current.currentBack,
                           cityTemp: self.locales.cities[indexPath.row + 1].current.tempratureString)
        
        return cityCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension MyCitiesViewController: UITableViewDelegate {
    // This method declares the behavior of what is to happen when the row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
