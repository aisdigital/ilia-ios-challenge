//
//  HomeTableViewControllerCoordinator.swift
//  MyMovies
//
//  Created by Wesley Brito on 04/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = HomeTableViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToHomeDetailTableViewController(movieId: Int, movieTitle: String) {
        let child = HomeDetailCoordinator(navigationController: navigationController)
        child.movieId = movieId
        child.movieTitle = movieTitle
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
        
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {
                if coordinator === child {
                    childCoordinators.remove(at: index)
                    break
                }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let homeDetailTableViewController = fromViewController as? HomeDetailTableViewController {
            childDidFinish(homeDetailTableViewController.coordinator)
        }
    }
}
