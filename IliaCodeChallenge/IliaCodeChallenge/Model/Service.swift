//
//  Service.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 25/01/22.
//

import Foundation
import Alamofire

class Service{

    private var movies: [Movie] = []
    
    var shouldShowErrorMessage: ((String) -> Void)?
    var updateLayout: (() -> Void)?


    
    func getMoviesListSize() -> Int{
        return movies.count
    }
    
    func getMovieAt(_ index: Int) -> Movie{
        return movies[index]
    }

    
    func getPopularMovies(){
        Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=1196e92a2075c7fc0f9b90091499a470", method: .get)
            .responseJSON{ (response) in
                print(">>>>> RESPOSTA DA API: ", response)
                guard let data = response.data else{return}
                
                do{
                    let moviesResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    self.movies = moviesResponse.results ?? []
                    self.updateLayout?()
                    print(self.movies)
                    
                }catch (let error){
                    self.shouldShowErrorMessage?(error.localizedDescription)
                }
                
            }
    }

    
}
