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
    var didChangeInTheathers: ((InTheatresViewModelProtocol) -> ())? {get set}
    

    init(networkManager : NetworkManager)
    func fetchNowPlayingMovies()
}

class InTheatresViewModel : InTheatresViewModelProtocol{
    
    private let networkManager : NetworkManager
    
    var inTheatres: InTheatres{
        didSet{
            didChangeInTheathers?(self)
        }
    }
    
    var didChangeInTheathers: ((InTheatresViewModelProtocol) -> ())?
    
    
    required init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.inTheatres = InTheatres(movies: [], page: 0, totalPages: 0)
        
    }
    
    
    
    func fetchNowPlayingMovies() {
        print(self.inTheatres.page + 1)
        
            networkManager.fetchInTheatresMovies(page: self.inTheatres.page + 1) { (nowPlaying, error) in
                
                var inTheatresHelper = self.inTheatres
                inTheatresHelper.movies.append(contentsOf: nowPlaying!.movies)
                inTheatresHelper.page = nowPlaying!.page
                
                
                self.inTheatres = inTheatresHelper
            }
            
        
        
        
        
            
            
    }
    
    
    
}
