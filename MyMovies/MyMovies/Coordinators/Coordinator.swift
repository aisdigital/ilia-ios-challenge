//
//  Coordinator.swift
//  MyMovies
//
//  Created by Wesley Brito on 04/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
