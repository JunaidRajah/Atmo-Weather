//
//  WeatherModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/02.
//

import Foundation

struct WeatherModel {
    let current: CurrentModel
    let daily: [DailyModel]
    let hourly: [HourlyModel]
}

struct CurrentModel {
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let rain: RainModel?
    let weather: [WeatherType]
    
    var tempratureString: String {
        return String(Int(temp))
    }
    
    var feelsLikeString: String {
        return String(Int(temp))
    }
    
    var uvString: String {
        switch uvi {
            case 0...2:
                return "\(uvi) Low"
            case 3...5:
                return "\(uvi) Moderate"
            case 6...7:
                return "\(uvi) High"
            case 8...10:
                return "\(uvi) Very High"
            default:
                return "\(uvi) Extreme"
        }
    }
    
    var windSpeedString: String {
        return "\(Int(windSpeed * 3.6)) km/h"
    }
    
    var windDirectionString: String {
        switch windDeg {
            case 337...360:
                return "North"
            case 0...22:
                return "North"
            case 23...67:
                return "North East"
            case 68...112:
                return "East"
            case 113...157:
                return "South East"
            case 158...202:
                return "South"
            case 203...247:
                return "South West"
            case 248...292:
                return "West"
            case 293...336:
                return "North West"
            default:
                return "Error"
        }
    }
}

struct HourlyModel {
    let dt: Int
    let temp: Double
    let weather: [WeatherType]
    
    var TempratureString: String {
        return String(Int(temp))
    }
}

struct DailyModel {
    let dt: Int
    let temp: TempModel
    let weather: [WeatherType]
}

struct TempModel {
    let day: Double
    let min: Double
    let max: Double
    
    var dayTempratureString: String {
        return String(Int(day))
    }
    
    var minTempratureString: String {
        return String(Int(min))
    }
    
    var maxTempratureString: String {
        return String(Int(max))
    }
}

struct RainModel {
    let the1h: Double?
    enum CodingKeys: String, CodingKey {
           case the1h = "1h"
    }
}

struct WeatherType {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    var conditionName: String {
        switch id {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }
}
