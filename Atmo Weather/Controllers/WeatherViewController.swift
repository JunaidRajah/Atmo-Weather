//
//  ViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/08/29.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController, CurrentWeatherViewDelegate, MoonButtonDelegate, Storyboarded {
    
    var coordinator: MainCoordinator?
    var weatherViewModel: WeatherViewModel?
    
    // MARK: - IBOutlets for dynamic views
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var weatherBack: UIImageView!
    
    private var cyclesButton: UIView!
    private var moonStack: UIStackView!
    
    static func createWeatherView(city: WeatherModel, coordinator: MainCoordinator) -> WeatherViewController {
        // swiftlint:disable force_cast
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "WeatherViewController") as! WeatherViewController
        // swiftlint:enable force_cast
        newViewController.weatherViewModel = WeatherViewModel(with: city)
        newViewController.coordinator = coordinator
        return newViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Set each element manually
    private func updateUI() {
        // swiftlint:disable force_cast
        weatherBack.image = UIImage(named: weatherViewModel!.currentWeatherBackground)
        addCurrentView()
        addMoonView()
        addHourlyView()
        addDailyView()
        addComfortView()
        addWindView()
    }
    
    private func addCurrentView() {
        if weatherViewModel?.cityWeatherModel != nil {
            let currentView = CurrentWeatherView.instanceFromNib() as! CurrentWeatherView
            currentView.setup(with: weatherViewModel!.cityWeatherModel)
            currentView.delegate = self
            mainStackView.addArrangedSubview(currentView)
        }
    }
    
    private func addMoonView() {
        if weatherViewModel?.currentCityDailyWeather != nil {
            moonStack = UIStackView()
            moonStack.axis = .vertical
            
            let moonBtn = MoonButtonView.instanceFromNib() as! MoonButtonView
            moonBtn.delegate = self
            cyclesButton = moonBtn
            mainStackView.addArrangedSubview(cyclesButton)
            
            for day in 0...6 {
                let moonView = MoonView.instanceFromNib() as! MoonView
                moonView.setup(day: weatherViewModel!.currentCityDailyWeather[day])
                moonView.isHidden = true
                moonView.alpha = 0
                moonStack.addArrangedSubview(moonView)
            }
            mainStackView.addArrangedSubview(moonStack)
        }
    }
    
    private func addHourlyView() {
        if weatherViewModel?.currentCityHourlyWeather != nil {
            let hourlyView = HourlyView.instanceFromNib() as! HourlyView
            hourlyView.setup(hourly: weatherViewModel!.currentCityHourlyWeather)
            mainStackView.addArrangedSubview(hourlyView)
        }
    }
    
    private func addDailyView() {
        if weatherViewModel?.currentCityDailyWeather != nil {
            let dayStack = UIStackView()
            dayStack.axis = .vertical
            for day in 1...6 {
                let dayView = DailyView.instanceFromNib() as! DailyView
                dayView.setup(day: weatherViewModel!.currentCityDailyWeather[day])
                dayStack.addArrangedSubview(dayView)
            }
            mainStackView.addArrangedSubview(dayStack)
        }
    }
    
    private func addComfortView() {
        if weatherViewModel?.currentWeather != nil {
            let comfortView = ComfortView.instanceFromNib() as! ComfortView
            comfortView.setup(current: weatherViewModel!.currentWeather)
            mainStackView.addArrangedSubview(comfortView)
        }
    }
    
    private func addWindView() {
        if weatherViewModel?.currentWeather != nil {
            let windView = WindView.instanceFromNib() as! WindView
            windView.setup(current: weatherViewModel!.currentWeather)
            mainStackView.addArrangedSubview(windView)
        }
    }
    
    func goToNextScene() {
        coordinator?.addCityFromWeather(vc: self)
    }
    
    func cyclesButtonPressed() {
        moonStack.arrangedSubviews.forEach { (moonView) in
            UIView.animate(withDuration: 0.8) {
                moonView.isHidden = !moonView.isHidden
                moonView.alpha = moonView.alpha == 0 ? 1 : 0
                moonView.layoutIfNeeded()
            }
        }
    }
}
