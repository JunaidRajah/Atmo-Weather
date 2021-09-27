//
//  MyCitiesTableViewCell.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/05.
//

import UIKit
import CoreLocation

final class MyCitiesTableViewCell: UITableViewCell, CurrentWeatherViewModelDelegate {
    
    @IBOutlet private weak var cellBack: UIImageView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var cityTemp: UILabel!
    static let identifier = "MyCitiesTableViewCell"
    private let currentViewModel = CurrentWeatherViewModel()
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCitiesTableViewCell", bundle: nil)
    }
    
    public func configure(city: WeatherModel) {
        currentViewModel.delegate = self
        currentViewModel.cityNameStringFromCoordinates(lat: city.lat, lon: city.lon)
        self.backgroundColor = .clear
        self.cellBack.image = UIImage(named: city.current.currentBack)
        self.cityTemp.text = "\(city.current.tempratureString)°"
        self.selectionStyle = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
    }
    
    func didSetCityName(cityName: String) {
        self.cityName.text = cityName
    }
}
