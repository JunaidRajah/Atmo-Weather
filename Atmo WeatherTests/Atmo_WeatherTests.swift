//
//  Atmo_WeatherTests.swift
//  Atmo WeatherTests
//
//  Created by Junaid Rajah on 2021/08/29.
//

import XCTest
@testable import Atmo_Weather

class Atmo_WeatherTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDayTempStringConversion() {
        let tempModel = TempModel(day: 12.20, min: 11, max: 14.50)
        XCTAssertEqual(tempModel.dayTempratureString, "12°")
    }
    
    func testMinTempStringConversion() {
        let tempModel = TempModel(day: 12.20, min: 11, max: 14.50)
        XCTAssertEqual(tempModel.minTempratureString, "11°")
    }
    
    func testMaxTempStringConversion() {
        let tempModel = TempModel(day: 12.20, min: 11, max: 14.50)
        XCTAssertEqual(tempModel.maxTempratureString, "14°")
    }
    
    func testWeatherConditionBolt() {
        XCTAssertEqual(createWeatherTypeFromId(id: 201).conditionName, "cloud.bolt")
    }
    
    func testWeatherConditionDrizzle() {
        XCTAssertEqual(createWeatherTypeFromId(id: 310).conditionName, "cloud.drizzle")
    }
    
    func testWeatherConditionRain() {
        XCTAssertEqual(createWeatherTypeFromId(id: 500).conditionName, "cloud.rain")
    }
    
    func testWeatherConditionSnow() {
        XCTAssertEqual(createWeatherTypeFromId(id: 622).conditionName, "cloud.snow")
    }
    
    func testWeatherConditionFog() {
        XCTAssertEqual(createWeatherTypeFromId(id: 702).conditionName, "cloud.fog")
    }
    
    func testWeatherConditionSun() {
        XCTAssertEqual(createWeatherTypeFromId(id: 800).conditionName, "sun.max")
    }
    
    func testWeatherConditionOther() {
        XCTAssertEqual(createWeatherTypeFromId(id: 2).conditionName, "cloud")
    }
    
    private func createWeatherTypeFromId(id: Int) -> WeatherType {
        WeatherType(id: id,
                    main: "Cloud",
                    description: "Partly Cloudy",
                    icon: "Cloud.png")
    }
    }
