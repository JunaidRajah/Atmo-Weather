//
//  WeatherManager.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/02.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?&appid=d98d345fe32e5bad306af56582e9f887&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session =  URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            
            let decodedData = try  decoder.decode(WeatherData.self, from: weatherData)
            
            let current = CurrentModel(sunrise: decodedData.current.sunrise,
                                       sunset: decodedData.current.sunset,
                                       temp: decodedData.current.temp,
                                       feelsLike: decodedData.current.feelsLike,
                                       pressure: decodedData.current.pressure,
                                       humidity: decodedData.current.humidity,
                                       uvi: decodedData.current.uvi,
                                       clouds: decodedData.current.clouds,
                                       visibility: decodedData.current.visibility,
                                       windSpeed: decodedData.current.windSpeed,
                                       windDeg: decodedData.current.windDeg,
                                       windGust: decodedData.current.windGust ?? 0,
                                       rain: RainModel(the1h: decodedData.current.rain?.the1h ?? 0),
                                       weather: [WeatherType(id: decodedData.current.weather[0].id,
                                                            main: decodedData.current.weather[0].main,
                                                            description: decodedData.current.weather[0].description,
                                                            icon: decodedData.current.weather[0].icon)])
            
            var daily = [DailyModel]()
            for day in decodedData.daily {
                let newDay = DailyModel(dt: day.dt,
                                        temp: TempModel(day: day.temp.day,
                                                        min: day.temp.min,
                                                        max: day.temp.max),
                                        weather: [WeatherType(id: day.weather[0].id,
                                                              main: day.weather[0].main,
                                                              description: day.weather[0].description,
                                                              icon: day.weather[0].icon)])
                daily.append(newDay)
            }
            
            var hourly = [HourlyModel]()
            for hour in decodedData.hourly {
                let newHour = HourlyModel(dt: hour.dt,
                                          temp: hour.temp,
                                          weather: [WeatherType(id: hour.weather[0].id,
                                                                main: hour.weather[0].main,
                                                                description: hour.weather[0].description,
                                                                icon: hour.weather[0].icon)])
                hourly.append(newHour)
            }
            
            let weather = WeatherModel(current: current, daily: daily, hourly: hourly)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
