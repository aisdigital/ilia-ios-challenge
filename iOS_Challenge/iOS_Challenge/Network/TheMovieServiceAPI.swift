//
//  TheMovieServiceAPI.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import Foundation
import UIKit

protocol UpdateDataDelegate {
    func updateData(result: [Film]?)
}

protocol UpdateImageDelegate{
    func updateImage(result: UIImage?)
}

class TheMovieServiceAPI {
    
    private let urlSession = URLSession.shared
    private let apiKey = NetworkConstants.apiKey
    
    var dataDelegate: UpdateDataDelegate?
    var imageDelegate: UpdateImageDelegate?
    
    
    func fetchMovies(page: Int){
        var films = [Film]()
        let url = URL(string: NetworkConstants.baseUrl + "/movie/now_playing?api_key=\(self.apiKey)&language=pt_BR&page=\(page)")!
        
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let task = urlSession.dataTask(with: urlRequest) {(data, response, error) in
            if error == nil{
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any?]{
                        
                        if let results = json["results"] as? Array<Dictionary<String, Any>>{
                            for movie in results{
                                
                                let title = movie["title"] as! String
                                let overview = movie["overview"] as! String
                                let releaseDate = movie["release_date"] as! String
                                let imagePath = movie["poster_path"] as! String
                                
                                let film = Film(name: title,
                                                description: overview,
                                                releaseDate: String(releaseDate.dropLast(6)),
                                                imagePath: imagePath)
                                
                                films.append(film)
                            }
                            self.dataDelegate?.updateData(result: films)
                        }
                    }
                } catch let err {
                    print(err.localizedDescription)
                }
            }
        }
        
        task.resume()
        
    }
    
    func loadImage(imagePath: String){
        var image: UIImage = UIImage()
        let urlString = NetworkConstants.baseImageUrl + imagePath
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error == nil{
                image = UIImage(data: data!)!
                self.imageDelegate?.updateImage(result: image)
            }
        }

        task.resume()
    }
    
    
}
