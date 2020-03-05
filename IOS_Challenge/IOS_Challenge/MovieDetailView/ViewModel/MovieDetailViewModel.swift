//
//  MovieDetailViewModel.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol: class {
    
    var movie: Movie? {get set}
    
    var didChangeMovie: ((MovieDetailViewModelProtocol) -> ())? {get set}
    
    init(networkManager : NetworkManager)
    func fetchMovie(movieID: Int, completionHandler: @escaping (_ success: Bool) -> ())
    
}

class MovieDetailViewModel : MovieDetailViewModelProtocol{
    
    private let networkManager : NetworkManager
    var movie: Movie?{
        didSet{
            self.didChangeMovie?(self)
        }
    }
    
    var didChangeMovie: ((MovieDetailViewModelProtocol) -> ())?
    
    required init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchMovie(movieID: Int, completionHandler: @escaping (_ success: Bool) -> ()) {
        networkManager.fetchMovieDetail(movieID: movieID) { (movie, error) in
            self.movie = movie
            completionHandler(true)
        }
    }
    
}
