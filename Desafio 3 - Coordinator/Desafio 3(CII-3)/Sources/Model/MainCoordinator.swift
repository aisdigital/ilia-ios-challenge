//
//  MainCoordinator.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 06/12/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MoviesViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func seeMovieDetails(data: MovieResult?) {
        let view = MovieDetailsViewController.instantiate()
        view.coordinator = self
        view.data = data
        navigationController.pushViewController(view, animated: true)
    }
}
