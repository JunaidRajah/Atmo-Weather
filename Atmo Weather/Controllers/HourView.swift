//
//  HourlyView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//

import UIKit

class HourView: UIView {

    @IBOutlet weak var hourTime: UILabel!
    @IBOutlet weak var hourImage: UIImageView!
    @IBOutlet weak var hourTemp: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HourView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(hour: HourlyModel) {
        hourTime.text = hour.timeString
        hourImage.image = UIImage(named: hour.weather[0].icon)
        hourTemp.text = hour.tempratureString
        
    }
}
