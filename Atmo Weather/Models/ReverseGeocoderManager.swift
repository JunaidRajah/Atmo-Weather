//
//  ReverseGeocoderManager.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/25.
//

import Foundation
import CoreLocation

protocol ReverseGeocoderManagerDelegate {
    func didGetCity(_ weatherManager: ReverseGeocoderManager, cityName: String)
    func didFailWithError(error: Error)
}

class ReverseGeocoderManager {
    var delegate: ReverseGeocoderManagerDelegate?
    private lazy var geocoder = CLGeocoder()
    private let locales = LocalLocales.locales
    private var locName = ""
    
    func reverseLocationName(from city: WeatherModel) {
        let location = CLLocation(latitude: city.lat, longitude: city.lon)
        reverse(location: location)
    }
    
    func reverseLocationNameWithCoordinates(lat: Double, lon: Double) {
        let location = CLLocation(latitude: lat, longitude: lon)
        reverse(location: location)
    }
    
    private func reverse(location: CLLocation) {
        self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let cityName = self.processResponse(withPlacemarks: placemarks, error: error) {
                self.delegate?.didGetCity(self, cityName: cityName)
            }
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String? {
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                return placemark.locality ?? "The Middle of Nowhere"
            } else {
                return "Unknown"
            }
        }
        return "Unknown"
    }
}
