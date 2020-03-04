//
//  TheMovieServiceAPI.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import Foundation

class TheMovieServiceAPI {
    
    private let urlSession = URLSession.shared
    private let apiKey = NetworkConstants.apiKey
    
    func fetchMovies(page: Int) -> [Film]{
        var films = [Film]()
        let url = URL(string: NetworkConstants.baseUrl + "/movie/now_playing?api_key=\(self.apiKey)&language=pt_BR&page=\(page)")!
        
        let task = urlSession.dataTask(with: url) {(data, response, error) in
            if error == nil{
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any?]{
                        
                        if let results = json["results"] as? Array<Dictionary<String, Any>>{
                            for movie in results{
                                
                                let title = movie["title"] as! String
                                let overview = movie["overview"] as! String
                                let releaseDate = movie["release_date"] as! String
                                let genre = NetworkUtils.getGenre(genresId: movie["genre_ids"] as! [Int])
                                print(genre)
                                let imagePath = movie["poster_path"] as! String
                                
                                let film = Film(name: title,
                                                description: overview,
                                                releaseDate: String(releaseDate.dropLast(6)),
                                                genre: genre,
                                                imagePath: imagePath)
                                
                                films.append(film)
                            }
                        }
                    }
                } catch let err {
                    print(err.localizedDescription)
                }
            }
        }
        
        task.resume()
        
        return films
    }
    
    
}
