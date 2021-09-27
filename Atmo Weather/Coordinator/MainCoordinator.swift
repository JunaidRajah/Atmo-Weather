//
//  MainCoordinator.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/25.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        let vc = PageViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addCityFromWeather(vc: WeatherViewController) {
        let destinationVC = MyCitiesViewController.instantiate()
        destinationVC.coordinator = self
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: nil, completion: nil)
    }
    
    func addCityFromCities(vc: MyCitiesViewController) {
        let destinationVC = SearchViewController.instantiate()
        destinationVC.coordinator = self
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: nil, completion: nil)
    }
    
    func backFromWeather(vc: MyCitiesViewController) {
        let destinationVC = PageViewController.instantiate()
        destinationVC.coordinator = self
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: nil, completion: nil)
    }
    
    func enteredNewCity(vc: SearchViewController) {
        let destinationVC = PageViewController.instantiate()
        destinationVC.coordinator = self
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: nil, completion: nil)
    }
}
