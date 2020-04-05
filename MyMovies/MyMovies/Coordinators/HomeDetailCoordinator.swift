//
//  HomeDetailCoordinator.swift
//  MyMovies
//
//  Created by Wesley Brito on 04/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation
import UIKit

class HomeDetailCoordinator: Coordinator {
    weak var parentCoordinator: HomeCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var movieId: Int = 0
    var movieTitle: String = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeDetailTableViewController.instantiate()
        vc.movieId = movieId
        vc.movieTitle = movieTitle
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToMovieTrailerViewController(youtubeKey: String) {
        let child = MovieTrailerCoordinator(navigationController: navigationController)
        child.youtubeKey = youtubeKey
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
    
}
