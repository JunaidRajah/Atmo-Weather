//
//  ViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/08/29.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var city: WeatherModel!
    lazy var geocoder = CLGeocoder()
    let locales = LocalLocales.locales
    
    //MARK: - IBOutlets for dynamic views
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var weatherBack: UIImageView!
    
    static func createWeatherView(city: WeatherModel) -> WeatherViewController {
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weather") as! WeatherViewController
        
        newViewController.city = city
        return newViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - Set each element manually
    
    private func updateUI() {
        
        weatherBack.image = UIImage(named: city.current.currentBack)
       
        
        let currentView = CurrentWeatherView.instanceFromNib() as! CurrentWeatherView
        let currentModel = currentWeather(index: self.city.index,
                                          lat: city.lat, lon: city.lon,
                                          temp: city.current.tempratureString,
                                          condition: city.current.weather[0].main,
                                          hourly: city.hourly,
                                          snow: city.current.snowString, rain: city.currentRainString)
        currentView.setup(current: currentModel)
        mainStackView.addArrangedSubview(currentView)
        
       
        let hourlyView = HourlyView.instanceFromNib() as! HourlyView
        hourlyView.setup(hourly: city.hourly)
        mainStackView.addArrangedSubview(hourlyView)
        
        let dayStack = UIStackView()
        dayStack.axis = .vertical
        
        for i in 1...6 {
            let dayView = DailyView.instanceFromNib() as! DailyView
            dayView.setup(day: city.daily[i])
            dayStack.addArrangedSubview(dayView)
        }
        
        mainStackView.addArrangedSubview(dayStack)
        
        let comfortView = ComfortView.instanceFromNib() as! ComfortView
        comfortView.setup(current: city.current)
        mainStackView.addArrangedSubview(comfortView)
        
        let windView = WindView.instanceFromNib() as! WindView
        windView.setup(current: city.current)
        mainStackView.addArrangedSubview(windView)
    }
    
    //MARK: - Reverse Geolocator Function
    
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
