//
//  MyCitiesViewModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/26.
//

import Foundation

final class MyCitiesViewModel {
    private let locales = LocalLocales.locales
    private let defaults = UserDefaults.standard
    
    var localesCount: Int {
        locales.cities.count - 1
    }
    
    func localesCity(at index: Int) -> WeatherModel {
        self.locales.cities[index + 1]
    }
    
    func deleteCity(at index: Int) {
        processDeletion(for: "cityLat", at: index)
        processDeletion(for: "cityLon", at: index)
        self.locales.cities.remove(at: index + 1)
    }
    
    private func processDeletion(for key: String, at index: Int) {
        var item = self.defaults.array(forKey: key) as? [Double]
        item?.remove(at: index)
        self.defaults.set(item, forKey: key)
    }
}
