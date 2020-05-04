//
//  MovieService.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 02/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct MovieService {
    let baseService = BaseAPIService.shared
    let environment = APIEnvironment.shared
    
    func getMovies(page: Int, completion: @escaping (Page<Movie>?, String?) -> Void) {
        let url = environment.getUrl(for: .movies, queryParameters: [.page: String(page)])
        baseService.get(url: url) { data, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data,
                let pageResponse = Page<Movie>.parseObject(data: data) else {
                    completion(nil, "There was an error parsing the movies data")
                    return
            }
            
            completion(pageResponse, nil)
        }
    }
    
    func searchMovies(with name: String, page: Int, completion: @escaping (Page<Movie>?, String?) -> Void) {
        let url = environment.getUrl(for: .searchMovies, queryParameters: [.movieTitleQuery: name.replacingOccurrences(of: " ", with: "%20"), .page: String(page)])
        baseService.get(url: url) { data, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data,
                let pageResponse = Page<Movie>.parseObject(data: data) else {
                    completion(nil, "There was an error parsing the movies data")
                    return
            }
            
            completion(pageResponse, nil)
        }
    }
    
    func getMovieDetails(with movieId: Int, completion: @escaping (Movie?, String?) -> Void) {
        let url = APIEnvironment.shared.getUrl(for: .movieDetails, urlParameters: [.movieId: String(movieId)])
        baseService.get(url: url) { data, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data,
                let movie = Movie.parseObject(data: data) else {
                    completion(nil, "There was an error parsing the movie data")
                    return
            }
            
            completion(movie, nil)
        }
    }
    
    func getMovieVideos(with movieId: Int, completion: @escaping ([MovieVideo]?, String?) -> Void) {
        let url = APIEnvironment.shared.getUrl(for: .movieVideos, urlParameters: [.movieId: String(movieId)])
        baseService.get(url: url) { data, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data,
                let movieVideos = MovieVideoResponse.parseObject(data: data) else {
                    completion(nil, "There was an error parsing the videos data")
                    return
            }
            
            completion(movieVideos.results, nil)
        }
    }
    
    func getMovieCastAndCrew(for movieId: Int, completion: @escaping (MovieCredits?, String?) -> Void) {
        let url = APIEnvironment.shared.getUrl(for: .movieCastAndCrew, urlParameters: [.movieId: String(movieId)])
        baseService.get(url: url) { data, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data,
                let movieCredits = MovieCredits.parseObject(data: data) else {
                    completion(nil, "There was an error parsing the videos credits")
                    return
            }
            
            completion(movieCredits, nil)
        }
    }
}
