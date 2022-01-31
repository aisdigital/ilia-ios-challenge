//
//  TabBarViewController.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 27/01/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let popularesVC = self.criarTabBar(viewController: HomeViewController(), titulo: "Populares", image: "film")
        
        let seriesVC = self.criarTabBar(viewController: TopMovieViewController(), titulo: "Top Aprovação", image: "play")
        
        viewControllers = [popularesVC, seriesVC]
    }
    
    func criarTabBar (viewController: UIViewController, titulo: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.navigationItem.title = titulo
//        viewController.tabBarItem.title = titulo
        viewController.tabBarItem.image = UIImage(named: image)
        
        return navController
    }
    
}
