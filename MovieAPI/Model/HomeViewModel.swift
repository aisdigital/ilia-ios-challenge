//
//  HomeViewModel.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 25/01/22.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    private let baseAPI = "https://api.themoviedb.org/3/movie/popular?api_key=52db72946dc3afe5a87fe0ab69aec074"
    private let keyApi = "52db72946dc3afe5a87fe0ab69aec074"
    private let urlSession = URLSession.shared
    private var movies: [MoviesItens] = []
    
    var updateLayout: (() -> Void)?
    var shoulError: (() -> Void)?
    
    func getMoviesQuantity()  -> Int {
        return movies.count
    }
    
    func getMovieAt(_ index: Int) -> MoviesItens {
        return movies[index]
    }
    
    func getPopularMovie() {
        AF.request(baseAPI, method: .get).responseJSON { (myresponse) in
            guard let data = myresponse.data else {return}

            do {
                let moviesModel = try JSONDecoder().decode(MovieModel.self, from: data)
                self.movies = moviesModel.results ?? []
                self.updateLayout?()
                print(self.movies)

            } catch (let error) {
                self.shoulError?()
            }
        }
    }
        
        func getTopMovie() {
            AF.request("https://api.themoviedb.org/3/movie/top_rated?api_key=52db72946dc3afe5a87fe0ab69aec074", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (response) in
                guard let data = response.data else {return}
                
                do {
                    let moviesModel = try JSONDecoder().decode(MovieModel.self, from: data)
                    self.movies = moviesModel.results ?? []
                    self.updateLayout?()
                    print(self.movies)
                    
                } catch (let error) {
                    self.shoulError?()
                }
            }
        }
        
}
