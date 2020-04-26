//  
//  HomePresenter.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: BasePresenterDelegate {
    var currentPage: Int { get set }
    var searchCurrentPage: Int { get set }
    func homePresenter(didGetMoviesSuccessfully movies: [MovieObject])
    func homePresenter(didSearchMoviesSuccessfully movies: [MovieObject])
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
        MovieDAO.getMovies(with: self.delegate?.currentPage ?? 1, success: { movies in
            self.delegate?.homePresenter(didGetMoviesSuccessfully: movies)
        }, failure: { message in
            self.delegate?.homePresenter(didFailToGetMovies: message)
        })
    }
    
    func searchMovie(with title: String) {

        MovieDAO.searchMovies(with: title, and: delegate?.searchCurrentPage ?? 1, success: { movies in
            self.delegate?.homePresenter(didSearchMoviesSuccessfully: movies)
            
        }, failure: { error in
            self.delegate?.homePresenter(didFailToGetMovies: error)
            
        })
    }
}
