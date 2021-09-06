//
//  MyCitiesTableViewCell.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/05.
//

import UIKit
import CoreLocation

class MyCitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBack: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    static let identifier = "MyCitiesTableViewCell"
    lazy var geocoder = CLGeocoder()
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCitiesTableViewCell", bundle: nil)
    }
    
    public func configure(lat: Double, lon: Double, cellBack: String, cityTemp: String ) {
        self.backgroundColor = .clear
        let location = CLLocation(latitude: lat, longitude: lon)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.cityName.text = self.processResponse(withPlacemarks: placemarks, error: error)
        }
        
        self.cellBack.image = UIImage(named: cellBack)
        self.cityTemp.text = "\(cityTemp)°"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Reverse Geo
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> String {

        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")

        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                return placemark.locality ?? "A place with no name"
            } else {
                return "Unknown"
            }
        }
        return "Unknown"
    }
}
