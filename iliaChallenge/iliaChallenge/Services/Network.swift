//
//  Network.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 30/10/21.
//

import Foundation
import Alamofire
import UIKit

final class Network {
    
    private func getMovie(completed: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        let request = "https://api.themoviedb.org/3/movie/now_playing?api_key=f13794b05602015b7f895fed45d8e8f7"

        AF.request(request).validate().responseJSON { response in
            guard response.error == nil else {
                    completed(.failure(.invalidResponse))
                return
                }
            
            do {
                if let data = response.data {
                    let movies = try JSONDecoder().decode([Movie].self, from: data)
                        completed(.success(movies))
                    } else {
                        completed(.failure(.invalidData))
                        return
                    }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                completed(.failure(.failedToDecodeResponse))

            }
        }
    }
    
}
    


