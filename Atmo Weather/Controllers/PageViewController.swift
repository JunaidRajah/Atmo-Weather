//
//  PageViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/03.
//

import UIKit
import CoreLocation

class PageViewController: UIPageViewController, PageViewModelDelegate {

    private let pageViewModel = PageViewModel()
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewModel.delegate = self
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))

        let image = UIImageView()
        image.image = UIImage(named: "Atmo Launch.png")
        image.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        customView.addSubview(image)
        var stored = pageViewModel.storedCount
        if stored <= 1 {
            stored = 2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + stored) {
            image.alpha = 0
            self.view.sendSubviewToBack(customView)
            }
        self.view.addSubview(customView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews where subView is UIScrollView {
            subView.frame = self.view.bounds
            
        }
        super.viewDidLayoutSubviews()
    }
    
    func modelLoadCompleted() {
        print("got here")
        if pageViewModel.isLocalesEqualToDefaults {
            let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
            appearance.pageIndicatorTintColor = UIColor.gray
            appearance.currentPageIndicatorTintColor = UIColor.white
            
            self.dataSource = self
            self.delegate = self
            self.view.backgroundColor = .clear
            let initialVC = WeatherViewController.createWeatherView(city: pageViewModel.returnCityAtIndex(index: 0))
            self.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
            self.didMove(toParent: self)
        }
    }
}

// MARK: - PageViewController Delegate and DataSource functions

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? WeatherViewController else {
            return nil
        }
        
        var index = currentVC.city.index
        if index == 0 {
            return nil
        }
        
        index -= 1
        let weatherViewController: WeatherViewController = WeatherViewController.createWeatherView(
            city: pageViewModel.returnCityAtIndex(index: index))
        return weatherViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? WeatherViewController else {
            return nil
        }
        
        var index = currentVC.city.index
        if index >= pageViewModel.localCount - 1 {
            return nil
        }
        
        index += 1
        let weatherViewController: WeatherViewController = WeatherViewController.createWeatherView(
            city: pageViewModel.returnCityAtIndex(index: index))
        return weatherViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageViewModel.localCount
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}
