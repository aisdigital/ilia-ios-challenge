//
//  Coordinator.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 21/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
