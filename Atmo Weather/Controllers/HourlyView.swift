//
//  HourlyView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//
// swiftlint:disable force_cast

import UIKit

final class HourlyView: UIScrollView {
    
    @IBOutlet private weak var stackView: UIStackView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HourlyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(hourly: [HourlyModel]) {
        for hour in 1...24 {
            let hourView = HourView.instanceFromNib() as! HourView
            let hourModel = hourly[hour]
            hourView.setup(hour: hourModel)
            stackView.addArrangedSubview(hourView)
        }
    }
}
