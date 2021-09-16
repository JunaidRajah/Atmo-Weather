//
//  CurrentWeatherView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//
// swiftlint:disable force_cast

import UIKit
import CoreLocation

protocol CurrentWeatherViewDelegate: AnyObject {
    func goToNextScene()
}

class CurrentWeatherView: UIView {

    weak var delegate: CurrentWeatherViewDelegate?
    lazy var geocoder = CLGeocoder()
    let locales = LocalLocales.locales
    
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var minMaxTemp: UILabel!
    @IBOutlet weak var currentConditions: UILabel!
    @IBOutlet weak var snowAmount: UILabel!
    @IBOutlet weak var rainAmount: UILabel!
    @IBOutlet weak var currentLocation: UILabel!
    
    @IBOutlet weak var rainIcon: UIImageView!
    @IBOutlet weak var snowIcon: UIImageView!
    @IBOutlet weak var currentLocationIcon: UIImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CurrentWeatherView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(current: currentWeather) {
    
        let location = CLLocation(latitude: current.lat, longitude: current.lon)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            let cityName = self.processResponse(withPlacemarks: placemarks, error: error)
            self.currentLocation.text = cityName
            self.locales.cities[current.index].name = cityName
        }
       
        currentTemp.text = current.temp
        minMaxTemp.text = current.minMaxString
        currentConditions.text = current.condition

        if current.snow != "0%" {
            snowIcon.isHidden = false
            snowAmount.isHidden = false
            snowAmount.text = current.snow
        }

        if current.rain != "0%" {
            rainIcon.isHidden = false
            rainAmount.isHidden = false
            rainAmount.text = current.rain
        }
    }
    
    @IBAction func addCityButtonPressed(_ sender: UIButton) {
        delegate?.goToNextScene()
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String {
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
