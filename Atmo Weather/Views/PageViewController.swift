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
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    private var cityData = [WeatherModel]()
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        locationManager.delegate = self
        weatherManager.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            }
        }
        super.viewDidLayoutSubviews()
    }
    
    private func setupPageController() {
        
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        
        self.dataSource = self
        self.delegate = self
        self.view.backgroundColor = .clear
        
        let initialVC = WeatherViewController.createWeatherView(city: cityData[0])
        self.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        self.didMove(toParent: self)
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
        
        let vc: WeatherViewController = WeatherViewController.createWeatherView(city: cityData[index])
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? WeatherViewController else {
            return nil
        }
        
        var index = currentVC.city.index
        
        if index >= self.cityData.count - 1 {
            return nil
        }
        
        index += 1

        let vc: WeatherViewController = WeatherViewController.createWeatherView(city: cityData[index])
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.cityData.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

//MARK: - WeatherManagerDelegate

extension PageViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityData.append(weather)
            self.setupPageController()
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
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

