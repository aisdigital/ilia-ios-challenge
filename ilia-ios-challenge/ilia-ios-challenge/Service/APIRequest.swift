//
//  APICall.swift
//  ilia-ios-challenge
//
//  Created by marcelo frost marchesan on 13/09/21.
//

import Foundation

struct APIRequest {
    
    private var dataTask: URLSessionDataTask?
    let resourceURL : URL
    
    init (url: String, list: String, key: String){
        
        let urlString = url+list+key
        
        guard let resourceURL = URL(string: urlString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }

    func getMoviesList(completionHandler: @escaping (MoviesData) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: self.resourceURL) { (data, response, error) in
            
            //check for errors
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    let moviesList = try decoder.decode(MoviesData.self, from: data!)
                    completionHandler(moviesList)
                } catch {
                    debugPrint("Error in parsing JSON")
                    print (error)
                }
            }
        }
        dataTask.resume()
    }

}

