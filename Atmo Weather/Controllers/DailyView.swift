//
//  DailyView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//
// swiftlint:disable force_cast

import UIKit

final class DailyView: UIView {
    
    @IBOutlet private weak var minMaxTemp: UILabel!
    @IBOutlet private weak var weatherIcon: UIImageView!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var rainIcon: UIImageView!
    @IBOutlet private weak var rainLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DailyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(day: DailyModel) {
        minMaxTemp.text = "\(day.temp.maxTempratureString) / \(day.temp.minTempratureString)"
        weatherIcon.image = UIImage(named: day.weather[0].icon)
        dayLabel.text = day.dayString
        dateLabel.text = day.dateString
        
        if day.pop != 0 {
            rainIcon.isHidden = false
            rainLabel.isHidden = false
            rainLabel.text = day.rainString
        }
    }
}
