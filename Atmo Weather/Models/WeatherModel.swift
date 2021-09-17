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
        total /= Double(daily.count)
        total *= 100
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

struct HourlyModel: DateConverter {
    let dt: Int
    let temp: Double
    let pop: Double
    let weather: [WeatherType]
    
    var tempratureString: String {
        return "\(Int(temp))°"
    }
    
    var timeString: String {
        return convertDate(date: Double(dt), format: "HH:mm")
    }
}

struct DailyModel: DateConverter {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: TempModel
    let weather: [WeatherType]
    let pop: Double
    
    var sunriseString: String {
        return self.convertDate(date: Double(sunrise), format: "HH:mm")
    }
    
    var sunsetString: String {
        return self.convertDate(date: Double(sunset), format: "HH:mm")
    }
    
    var moonriseString: String {
        return self.convertDate(date: Double(moonrise), format: "HH:mm")
    }
    
    var moonsetString: String {
        return self.convertDate(date: Double(moonset), format: "HH:mm")
    }
    
    var moonPhaseString: String {
        switch moonPhase {
        case 0.95...1:
            return "New Moon"
        case 0...0.05:
            return "New Moon"
        case 0.06...0.19:
            return "Waxing Crescent"
        case 0.2...0.3:
            return "First Quarter Moon"
        case 0.31...0.44:
            return "Waxing Gibous"
        case 0.45...0.55:
            return "Full Moon"
        case 0.56...0.69:
            return "Waning Gibous"
        case 0.7...0.8:
            return "Last Quarter Moon"
        case 0.81...0.94:
            return "Waning Crescent"
        default:
            return "Odd Moon"
        }
    }
    
    var dayString: String {
        return self.convertDate(date: Double(dt), format: "EEE")
    }
    
    var dateString: String {
        return self.convertDate(date: Double(dt), format: "dd LLL")
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

        for hour in 1...24 {
            if dailyHigh < hourly[hour].temp {
                dailyHigh = hourly[hour].temp
            }
            if dailyLow > hourly[hour].temp {
                dailyLow = hourly[hour].temp
            }
        }

        return "\(Int(dailyHigh))° / \(Int(dailyLow))°"
    }
}

protocol DateConverter {
    func convertDate(date: Double, format: String) -> String
}

extension DateConverter {
    func convertDate(date: Double, format: String) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}
