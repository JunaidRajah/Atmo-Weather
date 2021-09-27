//
//  WindView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/16.
//
// swiftlint:disable force_cast

import UIKit

final class WindView: UIView {
    
    @IBOutlet private weak var windDirectionLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "WindView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(current: CurrentModel) {
        windDirectionLabel.text = current.windDirectionString
        windSpeedLabel.text = current.windSpeedString
    }
}
