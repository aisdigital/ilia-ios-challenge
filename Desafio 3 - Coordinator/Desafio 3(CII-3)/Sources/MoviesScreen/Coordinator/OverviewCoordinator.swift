//
//  File.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 07/12/21.
//

import UIKit

class OverviewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var data: MovieResult?
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = MovieDetailsViewController.instantiate()
        view.coordinator = self
        view.data = data
        navigationController.pushViewController(view, animated: true)
    }
    
    func addDependency(coordinator: Coordinator?) {
        
    }
    
}
