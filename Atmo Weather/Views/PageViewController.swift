//
//  PageViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/03.
//

import UIKit
import CoreLocation

class PageViewController: UIPageViewController {
    
    private let defaults = UserDefaults.standard
    let locales = LocalLocales.locales
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    private var cityLat = [Double]()
    private var cityLon = [Double]()
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let image = UIImageView()
        image.image = UIImage(named: "Atmo Launch.png")
        image.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        customView.addSubview(image)
        let stored = Double((defaults.array(forKey: "cityLat") as? [Double])?.count ?? 2)
        DispatchQueue.main.asyncAfter(deadline: .now() + stored){
            image.alpha = 0
            self.view.sendSubviewToBack(customView)
            }
        self.view.addSubview(customView)
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        locationManager.delegate = self
        weatherManager.delegate = self
//        for city in locales.cities {
//            print(city.index)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            }
        }
        super.viewDidLayoutSubviews()
    }
    
    private func addCities() {
        if let lat = defaults.array(forKey: "cityLat") as? [Double] {
            cityLat = lat
        }
        
        if let lon = defaults.array(forKey: "cityLon") as? [Double] {
            cityLon = lon
        }
        
        var count = 1
        for i in 0..<cityLat.count {
            print(count)
            print(i)
            weatherManager.fetchWeather(latitude: cityLat[i], longitude: cityLon[i], index: count)
            count += 1
        }
    }
    
    private func setupPageController() {
        if self.locales.cities.count == ((self.defaults.array(forKey: "cityLat") as? [Double])?.count ?? 0) + 1 {
            let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
            appearance.pageIndicatorTintColor = UIColor.gray
            appearance.currentPageIndicatorTintColor = UIColor.white
            
            self.dataSource = self
            self.delegate = self
            self.view.backgroundColor = .clear
            let initialVC = WeatherViewController.createWeatherView(city: locales.cities[0])
            self.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
            self.didMove(toParent: self)
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? WeatherViewController else {
            return nil
        }
        
        var index = currentVC.city.index
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc: WeatherViewController = WeatherViewController.createWeatherView(city: locales.cities[index])
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? WeatherViewController else {
            return nil
        }
        
        var index = currentVC.city.index
        
        if index >= self.locales.cities.count - 1 {
            return nil
        }
        
        index += 1

        let vc: WeatherViewController = WeatherViewController.createWeatherView(city: locales.cities[index])
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.locales.cities.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

//MARK: - WeatherManagerDelegate

extension PageViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            if weather.index == 0 && self.locales.cities.isEmpty {
                self.locales.cities.append(weather)
                print(" First City Appended at index: \(weather.index)")
                
            } else if weather.index > 0 && self.locales.cities.count == weather.index {
                self.locales.cities.append(weather)
                print("Appended at index: \(weather.index)")
                
            } else if self.locales.cities.count > 0 && weather.index < self.locales.cities.count {
                self.locales.cities[weather.index] = weather
                print("Added at index: \(weather.index)")
                
            } else {
                let diff = (weather.index + 1) - self.locales.cities.count
                
                for _ in 0...diff - 1 {
                    self.locales.cities.append(weather)
                }
                print("Prematurely Added at index: \(weather.index)")
            }
            
            if weather.index == 0 {
                self.addCities()
            }
            
            print("local Cities: \(self.locales.cities.count)")
            print("stored Cities: \(((self.defaults.array(forKey: "cityLat") as? [Double])?.count ?? 0) + 1)")
            
            if self.locales.cities.count == ((self.defaults.array(forKey: "cityLat") as? [Double])?.count ?? 0) + 1 {
                self.setupPageController()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension PageViewController: CLLocationManagerDelegate {
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
            locationManager.stopUpdatingLocation()
        let alert = UIAlertController(title: "Settings", message: "Allow location from settings", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Location not granted", style: .default, handler: { action in
                switch action.style{
                case .default:
                    UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL, options: [:])  { (success: Bool) in
                       print("sent to settings")
                     }
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                @unknown default:
                    UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL, options: [:])  { (success: Bool) in
                       print("sent to settings")
                     }
                }
            }))
    }
}

