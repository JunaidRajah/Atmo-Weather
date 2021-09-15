//
//  DailyView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//

import UIKit

class DailyView: UIView {

    @IBOutlet weak var minMaxTemp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rainIcon: UIImageView!
    @IBOutlet weak var rainLabel: UILabel!
    
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
