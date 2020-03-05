//
//  NetworkManager.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation
import Alamofire

typealias FetchMoviesClosure = ((_ moviesNowPlaying : InTheatres?, _ error : AFError?) -> Void)
typealias FetchMovieClosure = ((_ movie: Movie?, _ error: AFError?) -> Void)
typealias FetchImageClosure = ((_ imageData : Data?,_ error : AFError?)-> Void)

protocol NetworkManagerProtocol {
    
    func fetchInTheatresMovies(page: Int, completionHandler: @escaping FetchMoviesClosure)
    func fetchMovieDetail(movieID: Int, completionHandler: @escaping FetchMovieClosure)
    func fetchMoviePoster(imagePath : String, completionHandler: @escaping FetchImageClosure)
    
}

class NetworkManager : NetworkManagerProtocol{
    
    private let apiKey = "4d36c680390ba8046573f3e491db3ef5" //API key necessary to make the calls.
    private let nowPlayingURL = "https://api.themoviedb.org/3/movie/now_playing" //URL to access movies that are playing on theathers
    private let movieDetailsURL = "https://api.themoviedb.org/3/movie/" //URL to access details of a movie
    private let posterURL = "https://image.tmdb.org/t/p/w500/" //URL to access the poster of a movie
    
    
    init() {}
    
    //MARK: - Fetch now playing movies
    
    /*
     Function to fetch now playing movies on theathers. It can receive language and page as parameters and a closure.
     */
    func fetchInTheatresMovies(page: Int = 1, completionHandler: @escaping FetchMoviesClosure){
        
        let params : Parameters = [
            "api_key" : apiKey,
            "language" : "en_US",
            "page" : page
            ]
        
        AF.request(nowPlayingURL, parameters: params, encoding: URLEncoding.queryString).response { (response) in
            
            switch response.result{
                
            case .success:
                guard let data = response.data, let movieAPI = try? JSONDecoder().decode(InTheatres.self, from: data) else{
                    
                    print("Erro de conversão.")
                    return
                }
                 
                completionHandler(movieAPI, nil)
                
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    //MARK: - Fetch movie detail

    /*
     Function to fetch full details of a single movie. It receives the movie id and a closure.
     **/
    func fetchMovieDetail(movieID: Int, completionHandler: @escaping FetchMovieClosure){

        let params : Parameters = [
            "api_key" : apiKey,
            "append_to_response" : "videos"
        ]

        AF.request("\(movieDetailsURL)\(movieID)", parameters: params).response { (response) in
            switch response.result{

            case .success:
                guard let data = response.data, let movie = try? JSONDecoder().decode(Movie.self, from: data) else{

                    print("Erro de conversão.")
                    return
                }
                completionHandler(movie, nil)

            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    
    //MARK: - Fetch image
    
    /*
     Function to fetch the movie's poster. It receive an string with the path for the image and a closure
     **/
    func fetchMoviePoster(imagePath : String, completionHandler: @escaping FetchImageClosure){
        
        AF.request("\(posterURL)\(imagePath)").response { (response) in
            
            switch response.result{
            case .success(let data):
                completionHandler(data, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        
        
    }
}
