//
//  WeatherModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/02.
//

import Foundation

struct WeatherModel {
    var name = ""
    let index: Int
    let lat: Double
    let lon: Double
    let current: CurrentModel
    let daily: [DailyModel]
    let hourly: [HourlyModel]
    
    var currentRainString: String {
        var total = 0.00
        for day in daily {
            total += day.pop
        }
        total = total / Double(daily.count)
        total = total * 100
        return "\(Int(total))%"
    }
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
    let snow: SnowModel?
    let weather: [WeatherType]
    
    var snowString: String {
        return "\(Int(snow?.the1h ?? 0))%"
    }
    
    var tempratureString: String {
        return "\(Int(temp))"
    }
    
    var feelsLikeString: String {
        return String(Int(feelsLike))
    }
    
    var uvString: String {
        switch Int(uvi) {
            case 0...2:
                return "\(Int(uvi)) Low"
            case 3...5:
                return "\(Int(uvi)) Moderate"
            case 6...7:
                return "\(Int(uvi)) High"
            case 8...10:
                return "\(Int(uvi)) Very High"
            default:
                return "\(Int(uvi)) Extreme"
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
    
    var currentBack: String {
        switch weather[0].icon {
        case "01d":
            return "clearDay"
        case "01n":
            return "clearNight"
        case "02d", "03d", "04d":
            return "cloudDay"
        case "02n", "03n", "04n":
            return "cloudNight"
        case "09d", "09n", "10d", "10n", "11d",
             "11n", "13d", "13n", "50d", "50n":
            return "gloom"
        default:
            return "clearDay"
        }
    }
}

struct HourlyModel {
    let dt: Int
    let temp: Double
    let pop: Double
    let weather: [WeatherType]
    
    var tempratureString: String {
        return "\(Int(temp))°"
    }
    
    var timeString: String {
        let date = Date(timeIntervalSince1970: Double(dt))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}

struct DailyModel {
    let dt: Int
    let temp: TempModel
    let weather: [WeatherType]
    let pop: Double
    
    var dayString: String {
        let date = Date(timeIntervalSince1970: Double(dt))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
    
    var dateString: String {
        let date = Date(timeIntervalSince1970: Double(dt))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL"
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
    
    var rainString: String {
        return "\(Int(pop * 100))%"
    }
}

struct TempModel {
    let day: Double
    let min: Double
    let max: Double
    
    var dayTempratureString: String {
        return "\(Int(day))°"
    }
    
    var minTempratureString: String {
        return "\(Int(min))°"
    }
    
    var maxTempratureString: String {
        return "\(Int(max))°"
    }
}

struct RainModel {
    let the1h: Double?
    enum CodingKeys: String, CodingKey {
           case the1h = "1h"
    }
}

struct SnowModel {
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

struct currentWeather {
    
    let index: Int
    
    let lat: Double
    let lon: Double
    
    let temp: String
    let condition: String
    
    let hourly: [HourlyModel]
    
    let snow: String
    let rain: String
    
    var minMaxString: String {
        var dailyHigh = -100.00
        var dailyLow = 100.00

        for i in 1...24 {
            if dailyHigh < hourly[i].temp {
                dailyHigh = hourly[i].temp
            }
            if dailyLow > hourly[i].temp {
                dailyLow = hourly[i].temp
            }
        }

        return "\(Int(dailyHigh))° / \(Int(dailyLow))°"
    }
}
