//
//  ComfortView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/16.
//
// swiftlint:disable force_cast

import UIKit

final class ComfortView: UIView {
    
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var humidityBar: UIProgressView!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var uvLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ComfortView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(current: CurrentModel) {
        humidityLabel.text = "\(current.humidity)%"
        humidityBar.progress = Float(current.humidity) / 100
        feelsLikeLabel.text = current.feelsLikeString
        uvLabel.text = current.uvString
    }
}
