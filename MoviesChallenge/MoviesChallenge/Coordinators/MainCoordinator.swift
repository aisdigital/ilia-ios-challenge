//
//  MainCoordinator.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 21/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit
import AVKit

class MainCoordinator: Coordinator {
    var childCoordinators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MoviesTableViewController.instantiate()
        let viewModel = MoviesTableViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDetailsMovie(idMovie: Int) {
        let vc = DetailsMovieViewController.instantiate()
        let viewModel = DetailsMovieViewModel(idMovie: idMovie)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func gotToTrailerMovie(idMovie: Int) {
        let vc = TrailerMovieViewController.instantiate()
        let viewModel = TrailerMovieViewModel(idMovie: idMovie)
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true, completion: nil)
    }
}
