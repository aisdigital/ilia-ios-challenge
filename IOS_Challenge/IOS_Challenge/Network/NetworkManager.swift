//
//  NetworkManager.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation
import Alamofire

typealias FetchMoviesClosure = ((_ moviesNowPlaying : NowPlaying?, _ error : AFError?) -> Void)
typealias FetchMovieClosure = ((_ movie: Movie?, _ error: AFError?) -> Void)

protocol NetworkManagerProtocol {
    
    func fetchNowPlayingMovies(page: Int, completionHandler: @escaping FetchMoviesClosure)
    //func fetchImages()
    
}

class NetworkManager : NetworkManagerProtocol{
    
    private let apiKey = "4d36c680390ba8046573f3e491db3ef5"
    private let nowPlayingURL = "https://api.themoviedb.org/3/movie/now_playing"
    private let movieDetailsURL = "https://api.themoviedb.org/3/movie/"
    
    
    init() {}
    
    
    
    /*Function to fetch now playing movies on theathers. It can receive language and page as parameters.
     Also receives a closure to send data.*/
    func fetchNowPlayingMovies(page: Int = 1, completionHandler: @escaping FetchMoviesClosure){
        
        let params : Parameters = [
            "api_key" : apiKey,
            "language" : "en_US",
            "page" : page
            ]
        
        AF.request(nowPlayingURL, parameters: params, encoding: URLEncoding.queryString).response { (response) in
            
            switch response.result{
                
            case .success:
                guard let data = response.data, let movieAPI = try? JSONDecoder().decode(NowPlaying.self, from: data) else{
                    
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

    func fetchMovieDetail(movieID: Int, completionHandler: @escaping FetchMovieClosure){

        let params : Parameters = [
            "api_key" : apiKey
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
    
}
