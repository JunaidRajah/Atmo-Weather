//
//  ViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/08/29.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var city: WeatherModel!
    lazy var geocoder = CLGeocoder()
    let locales = LocalLocales.locales
    
    //MARK: - IBOutlets for dynamic views
    
    @IBOutlet weak var weatherBack: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentMinMaxLabel: UILabel!
    @IBOutlet weak var currentConditionLabel: UILabel!
    
    @IBOutlet weak var hour1TimeLabel: UILabel!
    @IBOutlet weak var hour2TimeLabel: UILabel!
    @IBOutlet weak var hour3TimeLabel: UILabel!
    @IBOutlet weak var hour4TimeLabel: UILabel!
    @IBOutlet weak var hour5TimeLabel: UILabel!
    @IBOutlet weak var hour6TimeLabel: UILabel!
    @IBOutlet weak var hour7TimeLabel: UILabel!
    @IBOutlet weak var hour8TimeLabel: UILabel!
    @IBOutlet weak var hour9TimeLabel: UILabel!
    @IBOutlet weak var hour10TimeLabel: UILabel!
    @IBOutlet weak var hour11TimeLabel: UILabel!
    @IBOutlet weak var hour12TimeLabel: UILabel!
    @IBOutlet weak var hour13TimeLabel: UILabel!
    @IBOutlet weak var hour14TimeLabel: UILabel!
    @IBOutlet weak var hour15TimeLabel: UILabel!
    @IBOutlet weak var hour16TimeLabel: UILabel!
    @IBOutlet weak var hour17TimeLabel: UILabel!
    @IBOutlet weak var hour18TimeLabel: UILabel!
    @IBOutlet weak var hour19TimeLabel: UILabel!
    @IBOutlet weak var hour20TimeLabel: UILabel!
    @IBOutlet weak var hour21TimeLabel: UILabel!
    @IBOutlet weak var hour22TimeLabel: UILabel!
    @IBOutlet weak var hour23TimeLabel: UILabel!
    @IBOutlet weak var hour24TimeLabel: UILabel!
    
    @IBOutlet weak var hour1TempLabel: UILabel!
    @IBOutlet weak var hour2TempLabel: UILabel!
    @IBOutlet weak var hour3TempLabel: UILabel!
    @IBOutlet weak var hour4TempLabel: UILabel!
    @IBOutlet weak var hour5TempLabel: UILabel!
    @IBOutlet weak var hour6TempLabel: UILabel!
    @IBOutlet weak var hour7TempLabel: UILabel!
    @IBOutlet weak var hour8TempLabel: UILabel!
    @IBOutlet weak var hour9TempLabel: UILabel!
    @IBOutlet weak var hour10TempLabel: UILabel!
    @IBOutlet weak var hour11TempLabel: UILabel!
    @IBOutlet weak var hour12TempLabel: UILabel!
    @IBOutlet weak var hour13TempLabel: UILabel!
    @IBOutlet weak var hour14TempLabel: UILabel!
    @IBOutlet weak var hour15TempLabel: UILabel!
    @IBOutlet weak var hour16TempLabel: UILabel!
    @IBOutlet weak var hour17TempLabel: UILabel!
    @IBOutlet weak var hour18TempLabel: UILabel!
    @IBOutlet weak var hour19TempLabel: UILabel!
    @IBOutlet weak var hour20TempLabel: UILabel!
    @IBOutlet weak var hour21TempLabel: UILabel!
    @IBOutlet weak var hour22TempLabel: UILabel!
    @IBOutlet weak var hour23TempLabel: UILabel!
    @IBOutlet weak var hour24TempLabel: UILabel!
    
    @IBOutlet weak var hour1ConditionImage: UIImageView!
    @IBOutlet weak var hour2ConditionImage: UIImageView!
    @IBOutlet weak var hour3ConditionImage: UIImageView!
    @IBOutlet weak var hour4ConditionImage: UIImageView!
    @IBOutlet weak var hour5ConditionImage: UIImageView!
    @IBOutlet weak var hour6ConditionImage: UIImageView!
    @IBOutlet weak var hour7ConditionImage: UIImageView!
    @IBOutlet weak var hour8ConditionImage: UIImageView!
    @IBOutlet weak var hour9ConditionImage: UIImageView!
    @IBOutlet weak var hour10ConditionImage: UIImageView!
    @IBOutlet weak var hour11ConditionImage: UIImageView!
    @IBOutlet weak var hour12ConditionImage: UIImageView!
    @IBOutlet weak var hour13ConditionImage: UIImageView!
    @IBOutlet weak var hour14ConditionImage: UIImageView!
    @IBOutlet weak var hour15ConditionImage: UIImageView!
    @IBOutlet weak var hour16ConditionImage: UIImageView!
    @IBOutlet weak var hour17ConditionImage: UIImageView!
    @IBOutlet weak var hour18ConditionImage: UIImageView!
    @IBOutlet weak var hour19ConditionImage: UIImageView!
    @IBOutlet weak var hour20ConditionImage: UIImageView!
    @IBOutlet weak var hour21ConditionImage: UIImageView!
    @IBOutlet weak var hour22ConditionImage: UIImageView!
    @IBOutlet weak var hour23ConditionImage: UIImageView!
    @IBOutlet weak var hour24ConditionImage: UIImageView!
    
    @IBOutlet weak var daily1DateLabel: UILabel!
    @IBOutlet weak var daily2DateLabel: UILabel!
    @IBOutlet weak var daily3DateLabel: UILabel!
    @IBOutlet weak var daily4DateLabel: UILabel!
    @IBOutlet weak var daily5DateLabel: UILabel!
    @IBOutlet weak var daily6DateLabel: UILabel!
    
    @IBOutlet weak var daily2DayLabel: UILabel!
    @IBOutlet weak var daily3DayLabel: UILabel!
    @IBOutlet weak var daily4DayLabel: UILabel!
    @IBOutlet weak var daily5DayLabel: UILabel!
    @IBOutlet weak var daily6DayLabel: UILabel!
    
    @IBOutlet weak var daily1MinMaxLabel: UILabel!
    @IBOutlet weak var daily2MinMaxLabel: UILabel!
    @IBOutlet weak var daily3MinMaxLabel: UILabel!
    @IBOutlet weak var daily4MinMaxLabel: UILabel!
    @IBOutlet weak var daily5MinMaxLabel: UILabel!
    @IBOutlet weak var daily6MinMaxLabel: UILabel!
    
    @IBOutlet weak var daily1ConditionImage: UIImageView!
    @IBOutlet weak var daily2ConditionImage: UIImageView!
    @IBOutlet weak var daily3ConditionImage: UIImageView!
    @IBOutlet weak var daily4ConditionImage: UIImageView!
    @IBOutlet weak var daily5ConditionImage: UIImageView!
    @IBOutlet weak var daily6ConditionImage: UIImageView!
    
    
    @IBOutlet weak var currentRainIcon: UIImageView!
    @IBOutlet weak var daily1RainIcon: UIImageView!
    @IBOutlet weak var daily2RainIcon: UIImageView!
    @IBOutlet weak var daily3RainIcon: UIImageView!
    @IBOutlet weak var daily4RainIcon: UIImageView!
    @IBOutlet weak var daily5RainIcon: UIImageView!
    @IBOutlet weak var daily6RainIcon: UIImageView!
    
    
    @IBOutlet weak var currentRainLabel: UILabel!
    @IBOutlet weak var daily1RainLabel: UILabel!
    @IBOutlet weak var daily2RainLabel: UILabel!
    @IBOutlet weak var daily3RainLabel: UILabel!
    @IBOutlet weak var daily4RainLabel: UILabel!
    @IBOutlet weak var daily5RainLabel: UILabel!
    @IBOutlet weak var daily6RainLabel: UILabel!
    
    @IBOutlet weak var snowIcon: UIImageView!
    @IBOutlet weak var snowLabel: UILabel!
    
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityBar: UIProgressView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    static func createWeatherView(city: WeatherModel) -> WeatherViewController {
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weather") as! WeatherViewController
        
        newViewController.city = city
        return newViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - Set each element manually
    
    private func updateUI() {
        
        let location = CLLocation(latitude: city.lat, longitude: city.lon)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            let cityName = self.processResponse(withPlacemarks: placemarks, error: error)
            self.locationLabel.text = cityName
            self.locales.cities[self.city.index].name = cityName
        }
        
        var dailyHigh = -100.00
        var dailyLow = 100.00
        weatherBack.image = UIImage(named: city.current.currentBack)
        currentTempLabel.text = city.current.tempratureString
        
        for i in 1...24 {
            if dailyHigh < city.hourly[i].temp {
                dailyHigh = city.hourly[i].temp
            }
            if dailyLow > city.hourly[i].temp {
                dailyLow = city.hourly[i].temp
            }
        }
        
        currentMinMaxLabel.text = "\(Int(dailyHigh))° / \(Int(dailyLow))°"
        currentConditionLabel.text = city.current.weather[0].main
        
        hour1TimeLabel.text = city.hourly[0].timeString
        hour2TimeLabel.text = city.hourly[1].timeString
        hour3TimeLabel.text = city.hourly[2].timeString
        hour4TimeLabel.text = city.hourly[3].timeString
        hour5TimeLabel.text = city.hourly[4].timeString
        hour6TimeLabel.text = city.hourly[5].timeString
        hour7TimeLabel.text = city.hourly[6].timeString
        hour8TimeLabel.text = city.hourly[7].timeString
        hour9TimeLabel.text = city.hourly[8].timeString
        hour10TimeLabel.text = city.hourly[9].timeString
        hour11TimeLabel.text = city.hourly[10].timeString
        hour12TimeLabel.text = city.hourly[11].timeString
        hour13TimeLabel.text = city.hourly[12].timeString
        hour14TimeLabel.text = city.hourly[13].timeString
        hour15TimeLabel.text = city.hourly[14].timeString
        hour16TimeLabel.text = city.hourly[15].timeString
        hour17TimeLabel.text = city.hourly[16].timeString
        hour18TimeLabel.text = city.hourly[17].timeString
        hour19TimeLabel.text = city.hourly[18].timeString
        hour20TimeLabel.text = city.hourly[19].timeString
        hour21TimeLabel.text = city.hourly[20].timeString
        hour22TimeLabel.text = city.hourly[21].timeString
        hour23TimeLabel.text = city.hourly[22].timeString
        hour24TimeLabel.text = city.hourly[23].timeString
        
        hour1TempLabel.text = city.hourly[0].tempratureString
        hour2TempLabel.text = city.hourly[1].tempratureString
        hour3TempLabel.text = city.hourly[2].tempratureString
        hour4TempLabel.text = city.hourly[3].tempratureString
        hour5TempLabel.text = city.hourly[4].tempratureString
        hour6TempLabel.text = city.hourly[5].tempratureString
        hour7TempLabel.text = city.hourly[6].tempratureString
        hour8TempLabel.text = city.hourly[7].tempratureString
        hour9TempLabel.text = city.hourly[8].tempratureString
        hour10TempLabel.text = city.hourly[9].tempratureString
        hour11TempLabel.text = city.hourly[10].tempratureString
        hour12TempLabel.text = city.hourly[11].tempratureString
        hour13TempLabel.text = city.hourly[12].tempratureString
        hour14TempLabel.text = city.hourly[13].tempratureString
        hour15TempLabel.text = city.hourly[14].tempratureString
        hour16TempLabel.text = city.hourly[15].tempratureString
        hour17TempLabel.text = city.hourly[16].tempratureString
        hour18TempLabel.text = city.hourly[17].tempratureString
        hour19TempLabel.text = city.hourly[18].tempratureString
        hour20TempLabel.text = city.hourly[19].tempratureString
        hour21TempLabel.text = city.hourly[20].tempratureString
        hour22TempLabel.text = city.hourly[21].tempratureString
        hour23TempLabel.text = city.hourly[22].tempratureString
        hour24TempLabel.text = city.hourly[23].tempratureString
        
        hour1ConditionImage.image = UIImage(named: city.hourly[0].weather[0].icon)
        hour2ConditionImage.image = UIImage(named: city.hourly[1].weather[0].icon)
        hour3ConditionImage.image = UIImage(named: city.hourly[2].weather[0].icon)
        hour4ConditionImage.image = UIImage(named: city.hourly[3].weather[0].icon)
        hour5ConditionImage.image = UIImage(named: city.hourly[4].weather[0].icon)
        hour6ConditionImage.image = UIImage(named: city.hourly[5].weather[0].icon)
        hour7ConditionImage.image = UIImage(named: city.hourly[6].weather[0].icon)
        hour8ConditionImage.image = UIImage(named: city.hourly[7].weather[0].icon)
        hour9ConditionImage.image = UIImage(named: city.hourly[8].weather[0].icon)
        hour10ConditionImage.image = UIImage(named: city.hourly[9].weather[0].icon)
        hour11ConditionImage.image = UIImage(named: city.hourly[10].weather[0].icon)
        hour12ConditionImage.image = UIImage(named: city.hourly[11].weather[0].icon)
        hour13ConditionImage.image = UIImage(named: city.hourly[12].weather[0].icon)
        hour14ConditionImage.image = UIImage(named: city.hourly[13].weather[0].icon)
        hour15ConditionImage.image = UIImage(named: city.hourly[14].weather[0].icon)
        hour16ConditionImage.image = UIImage(named: city.hourly[15].weather[0].icon)
        hour17ConditionImage.image = UIImage(named: city.hourly[16].weather[0].icon)
        hour18ConditionImage.image = UIImage(named: city.hourly[17].weather[0].icon)
        hour19ConditionImage.image = UIImage(named: city.hourly[18].weather[0].icon)
        hour20ConditionImage.image = UIImage(named: city.hourly[19].weather[0].icon)
        hour21ConditionImage.image = UIImage(named: city.hourly[20].weather[0].icon)
        hour22ConditionImage.image = UIImage(named: city.hourly[21].weather[0].icon)
        hour23ConditionImage.image = UIImage(named: city.hourly[22].weather[0].icon)
        hour24ConditionImage.image = UIImage(named: city.hourly[23].weather[0].icon)
        
        daily1DateLabel.text = city.daily[0].dateString
        daily2DateLabel.text = city.daily[1].dateString
        daily3DateLabel.text = city.daily[2].dateString
        daily4DateLabel.text = city.daily[3].dateString
        daily5DateLabel.text = city.daily[4].dateString
        daily6DateLabel.text = city.daily[5].dateString
        
        daily2DayLabel.text = city.daily[1].dayString
        daily3DayLabel.text = city.daily[2].dayString
        daily4DayLabel.text = city.daily[3].dayString
        daily5DayLabel.text = city.daily[4].dayString
        daily6DayLabel.text = city.daily[5].dayString
        
        daily1MinMaxLabel.text = "\(city.daily[0].temp.maxTempratureString) / \(city.daily[0].temp.minTempratureString)"
        daily2MinMaxLabel.text = "\(city.daily[1].temp.maxTempratureString) / \(city.daily[1].temp.minTempratureString)"
        daily3MinMaxLabel.text = "\(city.daily[2].temp.maxTempratureString) / \(city.daily[2].temp.minTempratureString)"
        daily4MinMaxLabel.text = "\(city.daily[3].temp.maxTempratureString) / \(city.daily[3].temp.minTempratureString)"
        daily5MinMaxLabel.text = "\(city.daily[4].temp.maxTempratureString) / \(city.daily[4].temp.minTempratureString)"
        daily6MinMaxLabel.text = "\(city.daily[5].temp.maxTempratureString) / \(city.daily[5].temp.minTempratureString)"
        
        daily1ConditionImage.image = UIImage(named: city.daily[0].weather[0].icon)
        daily2ConditionImage.image = UIImage(named: city.daily[1].weather[0].icon)
        daily3ConditionImage.image = UIImage(named: city.daily[2].weather[0].icon)
        daily4ConditionImage.image = UIImage(named: city.daily[3].weather[0].icon)
        daily5ConditionImage.image = UIImage(named: city.daily[4].weather[0].icon)
        daily6ConditionImage.image = UIImage(named: city.daily[5].weather[0].icon)
        
        if city.currentRainString != "0%" {
            currentRainIcon.isHidden = false
            currentRainLabel.isHidden = false
            currentRainLabel.text = city.currentRainString
        }
        
        if city.daily[0].pop != 0 {
            daily1RainIcon.isHidden = false
            daily1RainLabel.isHidden = false
            daily1RainLabel.text = city.daily[0].rainString
        }
        
        if city.daily[1].pop != 0 {
            daily2RainIcon.isHidden = false
            daily2RainLabel.isHidden = false
            daily2RainLabel.text = city.daily[1].rainString
        }
        
        if city.daily[2].pop != 0 {
            daily3RainIcon.isHidden = false
            daily3RainLabel.isHidden = false
            daily3RainLabel.text = city.daily[2].rainString
        }
    
        if city.daily[3].pop != 0 {
            daily4RainIcon.isHidden = false
            daily4RainLabel.isHidden = false
            daily4RainLabel.text = city.daily[3].rainString
        }
        
        if city.daily[4].pop != 0 {
            daily5RainIcon.isHidden = false
            daily5RainLabel.isHidden = false
            daily5RainLabel.text = city.daily[4].rainString
        }
        
        if city.daily[5].pop != 0 {
            daily6RainIcon.isHidden = false
            daily6RainLabel.isHidden = false
            daily6RainLabel.text = city.daily[5].rainString
        }
        
        if city.current.snowString != "0%" {
            snowIcon.isHidden = false
            snowLabel.isHidden = false
            snowLabel.text = city.current.snowString
        }
        
        humidityLabel.text = "\(city.current.humidity)%"
        humidityBar.progress = Float(city.current.humidity) / 100
        
        windDirectionLabel.text = city.current.windDirectionString
        windSpeedLabel.text = city.current.windSpeedString
    }
    
    //MARK: - Reverse Geolocator Function
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String {
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")

        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                return placemark.locality ?? "The Middle of Nowhere"
            } else {
                return "Unknown"
            }
        }
        return "Unknown"
    }
}
