//
//  NowPlayingViewModel.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import Foundation

protocol NowPlayingNavigationProtocol: AnyObject {}

protocol NowPlayingViewModelProtocol {
    func selectMovie()
}

struct NowPlayingViewModel: NowPlayingViewModelProtocol {

    private var navigationDelegate: NowPlayingNavigationProtocol
    
    init(navigationDelegate: NowPlayingNavigationProtocol) {
        self.navigationDelegate = navigationDelegate
    }
    
    func selectMovie() {
        
    }

}

