//
//  MoviesCoordinator.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

protocol MoviesCoordinatorDelegate: class {
    func openMovie(movie: Movie)
}

final class MoviesCoordinator: Coordinator {
    
    var statusBarHeight: CGFloat {
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    private let window: UIWindow?
    private let presenter: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        let viewModel = MoviesViewModel()
        let moviesViewController = MoviesViewController(viewModel: viewModel)
        
        let presenter = UINavigationController(rootViewController: moviesViewController)
        self.presenter = presenter
        
        viewModel.coordinatorActions = self
    }
    
    func start() {
        window?.rootViewController = presenter
        window?.makeKeyAndVisible()
        setupPresenter()
    }
    
    private func setupPresenter() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .baseDarkGray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().tintColor = .white
        presenter.navigationBar.standardAppearance = appearance
        presenter.navigationBar.compactAppearance = appearance
        presenter.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func dismissViewController() {
        presenter.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension: MoviesCoordinatorDelegate
extension MoviesCoordinator: MoviesCoordinatorDelegate {
    func openMovie(movie: Movie) {
        print(movie.title)
        
        let viewModel = MovieDetailViewModel(movie: movie, coordinator: self)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        
        presenter.present(viewController, animated: true)
    }
}
