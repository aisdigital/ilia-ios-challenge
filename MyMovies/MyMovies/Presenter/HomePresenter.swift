//
//  HomePresenter.swift
//  MyMovies
//
//  Created by Wesley Brito on 03/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
    func movieFound(_ error: RequestErrors?)
    func searchFound(_ error: RequestErrors?)
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    
    var movieList: [Movie] = []
    var searchList: [Movie] = []
    var movieTotalPages: Int = 0
    var searchTotalPages: Int = 0
    
    
    func loadMovies(pageCount: Int = 1) {
        ServiceConnection().makeHTTPGetRequest(ServiceRepository.movieUrl(page: pageCount), MovieList.self) { (result, error) in
            self.movieList += result?.list ?? []
            if let total = result?.totalPages {
                self.movieTotalPages = total
            }
            self.delegate?.movieFound(error)
        }
    }
    
    func searchMovies(query: String, pageCount: Int = 1) {
        ServiceConnection().makeHTTPGetRequest(ServiceRepository.movieSearchUrl(query: query, page: pageCount), MovieList.self) { (result, error) in
            self.searchList += result?.list ?? []
            if let total = result?.totalPages {
                self.searchTotalPages = total
            }
            self.delegate?.searchFound(error)
        }
    }
    
    func cleanSearch() {
        searchList = []
    }
    
    // MARK: - Get Infors
    func getMovieTotalPages() -> Int {
        return movieTotalPages
    }
    
    func getSearchTotalPages() -> Int {
        return searchTotalPages
    }
    
    func getPosterUrl(_ index: Int, _ isSearching: Bool) -> URL? {
        switch isSearching {
        case true:
            if let image = URL(string: "https://image.tmdb.org/t/p/w342\(searchList[index].posterPath)") {
                return image
            }
        case false:
            if let image = URL(string: "https://image.tmdb.org/t/p/w342\(movieList[index].posterPath)") {
                return image
            }
        }
        return nil
    }
    
    func getBackdropPathUrl(_ index: Int, _ isSearching: Bool) -> URL? {
        switch isSearching {
        case true:
            if let image = URL(string: "https://image.tmdb.org/t/p/w342\(searchList[index].backdropPath)") {
                return image
            }
        case false:
            if let image = URL(string: "https://image.tmdb.org/t/p/w342\(movieList[index].backdropPath)") {
                return image
            }
        }
        return nil
    }
    
    func getId(_ index: Int, _ isSearching: Bool) -> Int {
        switch isSearching {
        case true:
            return searchList[index].id
        case false:
            return movieList[index].id
        }
    }
    
    func getTitle(_ index: Int, _ isSearching: Bool) -> String {
        switch isSearching {
        case true:
            return searchList[index].title
        case false:
            return movieList[index].title
        }
    }
    
    func getVoteAverage(_ index: Int, _ isSearching: Bool) -> Double {
        switch isSearching {
        case true:
            return searchList[index].voteAverage
        case false:
            return movieList[index].voteAverage
        }
    }
    
    func getMovieListCount() -> Int {
        return movieList.count
    }
    
    func getSearchListCount() -> Int {
        return searchList.count
    }
    
    func searchTextIsValid(text: String) -> Bool {
        if text.count > 0 {
            return true
        } else {
            return false
        }
    }
}
