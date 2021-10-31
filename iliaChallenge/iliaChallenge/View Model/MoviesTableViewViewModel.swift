//
//  MoviesTableViewViewModel.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 30/10/21.
//

import Foundation
import Alamofire

final class MoviesTableViewModel {

    var movies =  Movie()

    func fetchMovies(){
        Network.shared.getMovie(completed: { response in
            switch response {
                case .success(let result):
                    self.movies = result
                print(self.movies)
                case .failure(let error):
                print("Error during JSON serialization: \(error.localizedDescription). \(error.rawValue)")
            }
            
        })
        
    }
    
}
