//
//  Coordinator.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 06/12/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func addDependency(coordinator: Coordinator?)
}
