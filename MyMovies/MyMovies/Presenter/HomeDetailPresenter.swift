//
//  HomeDetailPresenter.swift
//  MyMovies
//
//  Created by Wesley Brito on 04/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation

import Foundation

protocol HomeDetailPresenterDelegate: AnyObject {
    func requestComplete(_ movieError: RequestErrors?, _ trailerError: RequestErrors?)
}

class HomeDetailPresenter {
    
    weak var delegate: HomeDetailPresenterDelegate?
    
    var movieDetail: MovieDetail?
    var movieTrailerKey: [MovieTrailerKey] = []
    var movieDetailError: RequestErrors?
    var movieTrailerError: RequestErrors?
    
    func loadMovieDetailTrailer(movieId: Int) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        ServiceConnection().makeHTTPGetRequest(ServiceRepository.movieDetailUrl(movieId: movieId), MovieDetail.self) { (result, error) in
            DispatchQueue.main.async {
                self.movieDetail = result
                self.movieDetailError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        ServiceConnection().makeHTTPGetRequest(ServiceRepository.movieTrailerUrl(movieId: movieId), MovieTrailer.self) { (result, error) in
            DispatchQueue.main.async {
                self.movieTrailerKey += result?.results ?? []
                self.movieTrailerError = error
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.requestComplete(self.movieDetailError, self.movieTrailerError)
    
        }
        
    }
    
    // MARK: - Get Infors
    
    func getMovieKey() -> String {
        if movieTrailerKey.count > 0 {
            return movieTrailerKey[0].key
        }
        return ""
    }
}
