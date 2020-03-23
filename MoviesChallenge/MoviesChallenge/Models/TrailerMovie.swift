//
//  TrailerMovie.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import Foundation

struct TrailerMovie: Decodable {
    let id: String
    let key: String
    
    func getUrlTrailer() -> URLRequest {
        let urlYoutube = "https://www.youtube.com/watch?v=\(key)"
        let urlRequest = URLRequest(url: URL(string: urlYoutube)!)
        return urlRequest
    }
}

struct ResultTrailer: Decodable {
    let id: Int
    let results: [TrailerMovie]
}
