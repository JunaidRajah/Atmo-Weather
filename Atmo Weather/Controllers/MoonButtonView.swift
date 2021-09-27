//
//  MoonButtonView.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/17.
//
// swiftlint:disable force_cast

import UIKit

protocol MoonButtonDelegate: AnyObject {
    func cyclesButtonPressed()
}

final class MoonButtonView: UIView {
    
    weak var delegate: MoonButtonDelegate?
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MoonButtonView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    @IBAction private func cyclesButtonPressed(_ sender: UIButton) {
        delegate?.cyclesButtonPressed()
    }
}
