//
//  HourlyView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//
// swiftlint:disable force_cast

import UIKit

final class HourView: UIView {
    
    @IBOutlet private weak var hourTime: UILabel!
    @IBOutlet private weak var hourImage: UIImageView!
    @IBOutlet private weak var hourTemp: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HourView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(hour: HourlyModel) {
        hourTime.text = hour.timeString
        hourImage.image = UIImage(named: hour.weather[0].icon)
        hourTemp.text = hour.tempratureString
        
    }
}
