//
//  MoonView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/16.
//
// swiftlint:disable force_cast

import UIKit

class MoonView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var moonriseLabel: UILabel!
    @IBOutlet weak var moonsetLabel: UILabel!
    @IBOutlet weak var moonPhaseLabel: UILabel!
    @IBOutlet weak var moonImage: UIImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MoonView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(day: DailyModel) {
        print("moonsetup")
        dateLabel.text = day.dateString
        sunriseLabel.text = day.sunriseString
        sunsetLabel.text = day.sunsetString
        moonriseLabel.text = day.moonriseString
        moonsetLabel.text = day.moonsetString
        moonPhaseLabel.text = day.moonPhaseString
        moonImage.image = UIImage(named: day.moonPhaseString)
    }
    
}
