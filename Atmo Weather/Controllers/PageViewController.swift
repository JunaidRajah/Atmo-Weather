//
//  PageViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/03.
//

import UIKit
import CoreLocation

final class PageViewController: UIPageViewController, PageViewModelDelegate, Storyboarded {
    
    var coordinator: MainCoordinator?
    private let loadingView = LoadingViewController()
    private let pageViewModel = PageViewModel()
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.start(container: self)
        pageViewModel.delegate = self
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
        if pageViewModel.isLocalesEqualToDefaults {
            let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
            appearance.pageIndicatorTintColor = UIColor.gray
            appearance.currentPageIndicatorTintColor = UIColor.white
            
            self.dataSource = self
            self.delegate = self
            self.view.backgroundColor = .clear
            let initialVC = WeatherViewController.createWeatherView(city: pageViewModel.returnCityAtIndex(index: 0), coordinator: self.coordinator!)
            self.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
            self.didMove(toParent: self)
        }
        loadingView.stop()
    }
}

// MARK: - PageViewController Delegate and DataSource functions

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return setPage(viewController: viewController, isBefore: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return setPage(viewController: viewController, isBefore: false)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pageViewModel.localCount
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
    private func setPage(viewController: UIViewController, isBefore: Bool) -> UIViewController? {
        guard let currentVC = viewController as? WeatherViewController else {
            return nil
        }
        var index = currentVC.weatherViewModel!.currentIndex
        
        if isBefore {
            if index == 0 {
                return nil
            }
            index -= 1
        } else {
            if index >= pageViewModel.localCount - 1 {
                return nil
            }
            index += 1
        }
        let weatherViewController: WeatherViewController = WeatherViewController.createWeatherView(
            city: pageViewModel.returnCityAtIndex(index: index), coordinator: self.coordinator!)
        return weatherViewController
    }
}
