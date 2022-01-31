//
//  APIMovie.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 30/01/22.
//

import Foundation

// https://api.themoviedb.org/3/movie/popular?api_key=52db72946dc3afe5a87fe0ab69aec074

struct Constants {
    static let Api_Key = "52db72946dc3afe5a87fe0ab69aec074"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedTogetData
}

class ApiMovie {
    
    static let shared = ApiMovie()
    
    func getPopularMovie(completion: @escaping (Result<[MoviesItens], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.Api_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
}
