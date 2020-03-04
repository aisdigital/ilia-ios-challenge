//
//  NetworkUtils.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import Foundation
import UIKit

class NetworkUtils {
    
    static func loadImage(imagePath: String) -> UIImage{
        var image = UIImage()
        let url = URL(string: NetworkConstants.baseImageUrl + imagePath)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error == nil{
                image = UIImage(data: data!)!
            }
        }
        
        task.resume()
        
        return image
    }
    
    static func getGenre(genresId: [Int]) -> String {
        var result: String = ""
        
        let url = URL(string: NetworkConstants.baseUrl + "/genre/movie/list?api_key=\(NetworkConstants.apiKey)&language=pt-BR")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any?]{
                    
                    if let genres = json["genres"] as? Array<Dictionary<String, Any>>{
                        for genreId in genresId{
                            for genre in genres{
                                
                                if(genreId == genre["id"] as! Int){
                                    if(result == ""){
                                        result = genre["name"] as! String
                                    }else{
                                        result += ", " + (genre["name"] as! String)
                                    }
                                    break
                                }
                                
                                print(result)
                            }
                        }
                    }
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
        
        task.resume()
        return result
    }
}
