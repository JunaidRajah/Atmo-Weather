//
//  WeatherData.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/02.
//

import Foundation

struct WeatherData: Codable {
    let lat: Double
    let lon: Double
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Int
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
    let rain: Rain?
    let snow: Snow?
    let weather: [Weather]
}

struct Hourly: Codable {
    let dt: Int
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
    let rain: Rain?
    let weather: [Weather]
    let pop: Double
}

struct Daily: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Double
    let humidity: Double
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Double
    let windGust: Double?
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Rain: Codable {
    let the1h: Double?
    enum CodingKeys: String, CodingKey {
        case the1h = "1h"
    }
}

struct Snow: Codable {
    let the1h: Double?
    enum CodingKeys: String, CodingKey {
        case the1h = "1h"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
