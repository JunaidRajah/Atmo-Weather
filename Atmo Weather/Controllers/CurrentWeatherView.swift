//
//  CurrentWeatherView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//
// swiftlint:disable force_cast

import UIKit

protocol CurrentWeatherViewDelegate: AnyObject {
    func goToNextScene()
}

final class CurrentWeatherView: UIView, CurrentWeatherViewModelDelegate {
    var coordinator: MainCoordinator?
    weak var delegate: CurrentWeatherViewDelegate?
    private var currentWeatherViewModel = CurrentWeatherViewModel()

    @IBOutlet private weak var currentTemp: UILabel!
    @IBOutlet private weak var minMaxTemp: UILabel!
    @IBOutlet private weak var currentConditions: UILabel!
    @IBOutlet private weak var snowAmount: UILabel!
    @IBOutlet private weak var rainAmount: UILabel!
    @IBOutlet private weak var currentLocation: UILabel!
    @IBOutlet private weak var rainIcon: UIImageView!
    @IBOutlet private weak var snowIcon: UIImageView!
    @IBOutlet private weak var currentLocationIcon: UIImageView!
    @IBOutlet private weak var conditionOverlay: UIImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CurrentWeatherView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(with city: WeatherModel) {
        currentWeatherViewModel.delegate = self
        conditionOverlay.image = UIImage.gifImageWithName(currentWeatherViewModel.conditionOverlayString(from: city))
        currentWeatherViewModel.cityNameString(from: city)
        currentTemp.text = city.current.tempratureString
        minMaxTemp.text = city.minMaxString
        currentConditions.text = city.current.weather[0].main
        
        if city.current.snowString != "0%" {
            snowIcon.isHidden = false
            snowAmount.isHidden = false
            snowAmount.text = city.current.snowString
        }
        
        if city.currentRainString != "0%" {
            rainIcon.isHidden = false
            rainAmount.isHidden = false
            rainAmount.text = city.currentRainString
        }
    }
    
    func didSetCityName(cityName: String) {
        currentLocation.text = cityName
    }
    
    @IBAction private func addCityButtonPressed(_ sender: UIButton) {
        delegate?.goToNextScene()
    }
}
