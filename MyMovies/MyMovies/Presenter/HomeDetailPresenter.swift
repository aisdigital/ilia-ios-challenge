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
    func movieDetailFound(_ error: RequestErrors?)
    func movieTrailerFound(_ error: RequestErrors?)
}

class HomeDetailPresenter {
    
    weak var delegate: HomeDetailPresenterDelegate?
    
    var movieDetail: MovieDetail?
    var movieTrailerKey: [MovieTrailerKey] = []
    
    func loadMovieDetailTrailer(movieId: Int) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        ServiceConnection().makeHTTPGetRequest(ServiceRepository.movieDetailUrl(movieId: movieId), MovieDetail.self) { (result, error) in
            DispatchQueue.main.async {
                self.movieDetail = result
                self.delegate?.movieDetailFound(error)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        ServiceConnection().makeHTTPGetRequest(ServiceRepository.movieTrailerUrl(movieId: movieId), MovieTrailer.self) { (result, error) in
            DispatchQueue.main.async {
                self.movieTrailerKey += result?.results ?? []
                self.delegate?.movieTrailerFound(error)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("success")
        }
        
    }
    
    // MARK: - Get Infors
    
    func getMovieKey() -> String {
        movieTrailerKey[0].key
    }
//    func getPosterUrl(_ index: Int) -> URL? {
//        if let image = URL(string: "https://image.tmdb.org/t/p/w342\(movieList[index].posterPath)") {
//            return image
//        }
//        return nil
//    }
//
//    func getBackdropPathUrl(_ index: Int) -> URL? {
//        if let image = URL(string: "https://image.tmdb.org/t/p/w342\(movieList[index].backdropPath)") {
//            return image
//        }
//        return nil
//    }
//
//
//    func getTitle(_ index: Int) -> String {
//        movieList[index].title
//    }
//
//    func getVoteAverage(_ index: Int) -> Double {
//        movieList[index].voteAverage
//    }
//
//    func getItensCount() -> Int {
//        return movieList.count
//    }
    
}
