//
//  NowPlayingViewModel.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation

protocol NowPlayingViewModelProtocol: class{
    
    var nowPlaying : NowPlaying {get set}
    var didChangeNowPlaying: ((NowPlayingViewModelProtocol) -> ())? {get set}
    

    init(networkManager : NetworkManager)
    func fetchNowPlayingMovies()
}

class NowPlayingViewModel : NowPlayingViewModelProtocol{
    
    private let networkManager : NetworkManager
    
    var nowPlaying: NowPlaying{
        didSet{
            didChangeNowPlaying?(self)
        }
    }
    
    var didChangeNowPlaying: ((NowPlayingViewModelProtocol) -> ())?
    
    
    required init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.nowPlaying = NowPlaying(movies: [], page: 0, totalPages: 0)
    }
    
    
    
    func fetchNowPlayingMovies() {
        
        networkManager.fetchNowPlayingMovies { (nowPlaying, error) in
            
                self.nowPlaying = nowPlaying!
            
        }
    }
    
    
    
}
