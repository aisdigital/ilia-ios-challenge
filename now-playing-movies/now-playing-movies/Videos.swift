//
//  Videos.swift
//  now-playing-movies
//
//  Created by iris on 05/11/21.
//

import Foundation

struct Videos: Decodable{
    var results: [Trailer]
}

struct Trailer: Decodable{
    var key: String
}
