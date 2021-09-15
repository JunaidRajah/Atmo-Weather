//
//  HourlyView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/15.
//

import UIKit

class HourlyView: UIScrollView {

    @IBOutlet weak var stackView: UIStackView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HourlyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(hourly: [HourlyModel]) {
        for i in 1...24 {
            let hourView = HourView.instanceFromNib() as! HourView
            let hourModel = hourly[i]
            hourView.setup(hour: hourModel)
            stackView.addArrangedSubview(hourView)
            
        }
        
    }
}
