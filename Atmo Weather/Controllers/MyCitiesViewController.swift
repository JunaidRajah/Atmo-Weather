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
    let defaults = UserDefaults.standard
    
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

// MARK: - UITableView DataSource functions

extension MyCitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locales.cities.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cityCell = tableView.dequeueReusableCell(withIdentifier: MyCitiesTableViewCell.identifier, for: indexPath) as! MyCitiesTableViewCell
        // swiftlint:enable force_cast
        cityCell.configure(lat: self.locales.cities[indexPath.row + 1].lat,
                           lon: self.locales.cities[indexPath.row + 1].lon,
                           cellBack: self.locales.cities[indexPath.row + 1].current.currentBack,
                           cityTemp: self.locales.cities[indexPath.row + 1].current.tempratureString)
        
        return cityCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableView Delegate functions

extension MyCitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var arrLat = self.defaults.array(forKey: "cityLat") as? [Double]
        arrLat?.remove(at: indexPath.row)
        defaults.set(arrLat, forKey: "cityLat")
        
        var arrLon = self.defaults.array(forKey: "cityLon") as? [Double]
        arrLon?.remove(at: indexPath.row)
        defaults.set(arrLon, forKey: "cityLon")
        
        locales.cities.remove(at: indexPath.row + 1)
        performSegue(withIdentifier: "myCitiesToWeather", sender: self)
    }
}
