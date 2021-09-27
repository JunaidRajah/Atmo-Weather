//
//  MyCitiesViewController.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/05.
//

import UIKit
import CoreLocation

final class MyCitiesViewController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    private let myCitiesViewModel = MyCitiesViewModel()
    @IBOutlet private weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.register(MyCitiesTableViewCell.nib(), forCellReuseIdentifier: MyCitiesTableViewCell.identifier)
        cityTableView?.delegate = self
        cityTableView?.dataSource = self
        
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        coordinator?.backFromWeather(vc: self)
    }
    
    @IBAction private func addCityButtonPressed(_ sender: UIButton) {
        coordinator?.addCityFromCities(vc: self)
    }
}

// MARK: - UITableView DataSource functions

extension MyCitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myCitiesViewModel.localesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cityCell = tableView.dequeueReusableCell(withIdentifier: MyCitiesTableViewCell.identifier, for: indexPath) as! MyCitiesTableViewCell
        cityCell.configure(city: myCitiesViewModel.localesCity(at: indexPath.row))
        
        return cityCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            tableView.deselectRow(at: indexPath, animated: true)
            self.myCitiesViewModel.deleteCity(at: indexPath.row)
            self.coordinator?.backFromWeather(vc: self)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .black
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK: - UITableView Delegate functions

extension MyCitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
