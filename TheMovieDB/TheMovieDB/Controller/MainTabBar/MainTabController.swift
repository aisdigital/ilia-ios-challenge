//
//  MainTabController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

class MainTabController: UITabBarController {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        
        ///NowPlaying
        let viewModelNowplaying = NowPlayingViewModel(navigationDelegate: self)
        let nowplaying = NowPlayingController(viewModel: viewModelNowplaying)
        let nav1 = templateNavigationController(image: UIImage(systemName: "house"), rootViewController: nowplaying, title: "Now Playing")
        
        ///Popular
        let popular = PopularController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav2 = templateNavigationController(image: UIImage(systemName: "list.bullet.below.rectangle"), rootViewController: popular, title: "Popular")
        
        ///TopRated
        let toprated = TopRatedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav3 = templateNavigationController(image: UIImage(systemName: "globe"), rootViewController: toprated, title: "Top Rated")
        
        ///Search
        let search = SearchController()
        let nav4 = templateNavigationController(image: UIImage(systemName: "magnifyingglass"), rootViewController: search, title: "Search Movies")
        
        viewControllers = [nav1,nav2,nav3,nav4]
        
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        return nav
    }
    
}

extension MainTabController: NowPlayingNavigationProtocol {
    
}
