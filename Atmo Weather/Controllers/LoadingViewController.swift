//
//  LoadingViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/17.
//

import UIKit

class LoadingViewController: UIViewController {

    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Atmo Launch.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.transform = CGAffineTransform( translationX: 0.0, y: 80.0 )
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public func start(container: UIViewController) {
        container.addChild(self)
        self.view.frame = container.view.frame
        container.view.addSubview(self.view)
        self.didMove(toParent: container)
    }

    public func stop() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
