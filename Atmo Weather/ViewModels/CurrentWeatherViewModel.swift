//
//  currentWeatherViewModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/23.
//

import Foundation
import CoreLocation

protocol CurrentWeatherViewModelDelegate {
    func didSetCityName(cityName: String) 
}

final class CurrentWeatherViewModel {
    
    var delegate: CurrentWeatherViewModelDelegate?
    private var locName = ""
    private var weatherManager = ReverseGeocoderManager()
    
    init() {
        weatherManager.delegate = self
    }
    
    func conditionOverlayString(from city: WeatherModel) -> String {
        switch city.current.weather[0].icon {
        case "01d":
            return "day"
        case "01n":
            return "night"
        case "02d", "03d", "04d":
            return "cloud"
        case "02n", "03n", "04n":
            return "cloud2"
        case "09d", "09n", "10d", "10n",
             "13d", "13n", "50d", "50n":
            return "rain"
        case "11d", "11n":
            return "storm"
        default:
            return "day"
        }
    }
    
    func cityNameString(from city: WeatherModel) {
        weatherManager.reverseLocationName(from: city)
    }
    
    func cityNameStringFromCoordinates(lat: Double, lon: Double) {
        weatherManager.reverseLocationNameWithCoordinates(lat: lat, lon: lon)
    }
}

extension CurrentWeatherViewModel: ReverseGeocoderManagerDelegate {
    func didGetCity(_ weatherManager: ReverseGeocoderManager, cityName: String) {
        DispatchQueue.main.async {
            self.delegate?.didSetCityName(cityName: cityName)
        }
    }
    
    func didFailWithError(error: Error) {
        self.delegate?.didSetCityName(cityName: "Unknown Locale")
    }
}
