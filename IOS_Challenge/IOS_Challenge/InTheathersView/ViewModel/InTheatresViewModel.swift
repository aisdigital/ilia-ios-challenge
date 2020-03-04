//
//  NowPlayingViewModel.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation

protocol InTheatresViewModelProtocol: class{
    
    var inTheatres : InTheatres {get set}
    var didChangeNowPlaying: ((InTheatresViewModelProtocol) -> ())? {get set}
    

    init(networkManager : NetworkManager)
    func fetchNowPlayingMovies()
}

class InTheatresViewModel : InTheatresViewModelProtocol{
    
    private let networkManager : NetworkManager
    
    var inTheatres: InTheatres{
        didSet{
            didChangeNowPlaying?(self)
        }
    }
    
    var didChangeNowPlaying: ((InTheatresViewModelProtocol) -> ())?
    
    
    required init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.inTheatres = InTheatres(movies: [], page: 0, totalPages: 0)
    }
    
    
    
    func fetchNowPlayingMovies() {
        
        networkManager.fetchInTheatresMovies { (nowPlaying, error) in
            
                self.inTheatres = nowPlaying!
            
        }
    }
    
    
    
}
