//
//  WeatherViewModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/23.
//

import Foundation

final class WeatherViewModel {
    
    private var city: WeatherModel
    
    init(with city: WeatherModel) {
        self.city = city
    }
    
    var currentWeatherBackground: String {
        city.current.currentBack
    }
    
    var cityWeatherModel: WeatherModel {
        city
    }
    
    var currentCityDailyWeather: [DailyModel] {
        city.daily
    }
    
    var currentCityHourlyWeather: [HourlyModel] {
        city.hourly
    }
    
    var currentWeather: CurrentModel {
        city.current
    }
    
    var currentIndex: Int {
        city.index
    }
}
