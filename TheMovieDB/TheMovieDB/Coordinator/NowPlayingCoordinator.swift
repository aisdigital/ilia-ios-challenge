//
//  NowPlayingCoordinator.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

final class NowPlayingCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let presenter: UINavigationController

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let viewModel = NowPlayingViewModel(navigationDelegate: self)
        let viewController = NowPlayingController(viewModel: viewModel)
        presenter.push(viewController)
    }
}

extension NowPlayingCoordinator: NowPlayingNavigationProtocol {
    
}
