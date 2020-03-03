//
//  NetworkManager.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation
import Alamofire

typealias FetchNowPlayingMoviesClosure = ((_ movies : [Movie]?, _ error : AFError?) -> Void)

protocol NetworkManagerProtocol {
    
    func fetchNowPlayingMovies(language: String, page: Int, completionHandler: @escaping FetchNowPlayingMoviesClosure)
    //func fetchImages()
    
}

class NetworkManager : NetworkManagerProtocol{
    
    private let apiKey = "4d36c680390ba8046573f3e491db3ef5"
    private let path = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    
    
    init() {}
    
    
    
    /*Function to fetch now playing movies on theathers. It can receive language and page as parameters.
     Also receives a closure to send data.*/
    func fetchNowPlayingMovies(language: String = "en_US", page: Int = 1, completionHandler: @escaping FetchNowPlayingMoviesClosure){
        
        AF.request("\(path+apiKey)&\(language)&\(page)").validate().response { (response) in
            
            switch response.result{
                
            case .success:
                guard let data = response.data, let movieAPI = try? JSONDecoder().decode(MovieAPIResponse.self, from: data) else{
                    
                    print("Erro de conversão.")
                    return
                }
                 
                completionHandler(movieAPI.movies, nil)
                
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    

    
    
    
    
}
