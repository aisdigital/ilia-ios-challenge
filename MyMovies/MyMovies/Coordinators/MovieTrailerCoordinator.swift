//
//  MovieTrailerCoordinator.swift
//  MyMovies
//
//  Created by Wesley Brito on 05/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation
import UIKit

class MovieTrailerCoordinator: Coordinator {
    weak var parentCoordinator: HomeDetailCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var youtubeKey: String = ""

    init(navigationController: UINavigationController) {
       self.navigationController = navigationController
    }

    func start() {
       let vc = MovieTrailerViewController.instantiate()
       vc.youtubeKey = youtubeKey
       vc.coordinator = self
       navigationController.pushViewController(vc, animated: false)
    }
    
    func movieTrailerDidFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
