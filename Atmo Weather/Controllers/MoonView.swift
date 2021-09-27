//
//  MoonView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/16.
//
// swiftlint:disable force_cast

import UIKit

final class MoonView: UIView {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    @IBOutlet private weak var moonriseLabel: UILabel!
    @IBOutlet private weak var moonsetLabel: UILabel!
    @IBOutlet private weak var moonPhaseLabel: UILabel!
    @IBOutlet private weak var moonImage: UIImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MoonView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(day: DailyModel) {
        dateLabel.text = day.dateString
        sunriseLabel.text = day.sunriseString
        sunsetLabel.text = day.sunsetString
        moonriseLabel.text = day.moonriseString
        moonsetLabel.text = day.moonsetString
        moonPhaseLabel.text = day.moonPhaseString
        moonImage.image = UIImage(named: day.moonPhaseString)
    }
}
