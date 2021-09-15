//
//  ComfortView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/16.
//

import UIKit

class ComfortView: UIView {

    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityBar: UIProgressView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    
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
