//
//  PageViewModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/16.
//

import Foundation
import CoreLocation

protocol PageViewModelDelegate: AnyObject {
    func modelLoadCompleted()
}

class PageViewModel: NSObject {
    
    weak var delegate: PageViewModelDelegate?
    private let defaults = UserDefaults.standard
    private let locales = LocalLocales.locales
    private var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()
    
    private var cityLat = [Double]()
    private var cityLon = [Double]()
    
    var localCount: Int {
        locales.cities.count
    }
    
    var isLocalesEqualToDefaults: Bool {
        self.locales.cities.count == ((self.defaults.array(forKey: "cityLat") as? [Double])?.count ?? 0) + 1
    }
    
    var storedCount: Double {
        Double((defaults.array(forKey: "cityLat") as? [Double])?.count ?? 2)
    }
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.delegate = self
        weatherManager.delegate = self
    }
    
    private func addCities() {
        if let lat = defaults.array(forKey: "cityLat") as? [Double] {
            cityLat = lat
        }
        
        if let lon = defaults.array(forKey: "cityLon") as? [Double] {
            cityLon = lon
        }
        
        var count = 1
        for city in 0..<cityLat.count {
            weatherManager.fetchWeather(latitude: cityLat[city], longitude: cityLon[city], index: count)
            count += 1
        }
    }
    
    func returnCityAtIndex(index: Int) -> WeatherModel {
        locales.cities[index]
    }
    
    func allCitiesLoaded() {
        delegate?.modelLoadCompleted()
    }
}

// MARK: - WeatherManagerDelegate

extension PageViewModel: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            if weather.index == 0 && self.locales.cities.isEmpty {
                self.locales.cities.append(weather)
                
            } else if weather.index > 0 && self.locales.cities.count == weather.index {
                self.locales.cities.append(weather)
                
            } else if !self.locales.cities.isEmpty && weather.index < self.locales.cities.count {
                self.locales.cities[weather.index] = weather
                
            } else {
                let diff = (weather.index + 1) - self.locales.cities.count
                
                for _ in 0...diff - 1 {
                    self.locales.cities.append(weather)
                }
            }
            
            if weather.index == 0 {
                self.addCities()
            }

            if self.isLocalesEqualToDefaults {
                self.allCitiesLoaded()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension PageViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon, index: 0)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error::: \(error)")
    }
}
