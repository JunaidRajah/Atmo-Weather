//
//  PageViewModel.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/04.
//

//import Foundation
//import CoreLocation
//
//class PageViewModel {
//
//}
//
//extension PageViewModel: WeatherManagerDelegate {
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        DispatchQueue.main.async {
//            self.wText.text = self.wText.text + weather.tempratureString
//        }
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}
//
////MARK: - CLLocationManagerDelegate
//
//extension PageViewModel: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            locationManager.stopUpdatingLocation()
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.latitude
//            weatherManager.fetchWeather(latitude: lat, longitude: lon)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//}
