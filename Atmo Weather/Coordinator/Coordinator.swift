//
//  Coordinator.swift
//  Atmo Weather
//
//  Created by Junaid Rajah on 2021/09/25.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
