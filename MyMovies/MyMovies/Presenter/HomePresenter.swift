//
//  HomePresenter.swift
//  MyMovies
//
//  Created by Wesley Brito on 03/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
    func movieFound(_ error: RequestErrors?, totalPages: Int)
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    
    var movieList: [Movie] = []
    var totalPages: Int = 0
    
    
    func loadMovies(pageCount: Int = 1) {
        ServiceConnection().makeHTTPGetRequest(ServiceRepository.movieUrl(page: pageCount), MovieList.self) { (result, error) in
            self.movieList += result?.list ?? []
            if let total = result?.totalPages {
                self.totalPages = total
            }
            self.delegate?.movieFound(error, totalPages: self.totalPages)
        }
    }
    
    // MARK: - Get Infors
    func getPosterUrl(_ index: Int) -> URL? {
        if let image = URL(string: "https://image.tmdb.org/t/p/w342\(movieList[index].posterPath)") {
            return image
        }
        return nil
    }
    
    func getBackdropPathUrl(_ index: Int) -> URL? {
        if let image = URL(string: "https://image.tmdb.org/t/p/w342\(movieList[index].backdropPath)") {
            return image
        }
        return nil
    }
    
    func getTitle(_ index: Int) -> String {
        movieList[index].title
    }
    
    func getVoteAverage(_ index: Int) -> Double {
        movieList[index].voteAverage
    }
    
    func getItensCount() -> Int {
        return movieList.count
    }
    
}
