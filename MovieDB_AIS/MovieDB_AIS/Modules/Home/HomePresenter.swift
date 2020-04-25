//  
//  HomePresenter.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: BasePresenterDelegate {
    func homePresenter(didGetMoviesSuccessfully movies: [MovieObject])
    func homePresenter(didFailToGetMovies failMessage: String)
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    
    init(delegate: HomePresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
        getMovies()
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
    
    func getMovies() {
        MovieDAO.getMovies(success: { movies in
            self.delegate?.homePresenter(didGetMoviesSuccessfully: movies)
        }, failure: { message in
            self.delegate?.homePresenter(didFailToGetMovies: message)
        })
    }
}
