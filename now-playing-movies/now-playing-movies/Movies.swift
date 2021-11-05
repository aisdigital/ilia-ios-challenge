//
//  Movies.swift
//  now-playing-movies
//
//  Created by iris on 04/11/21.
//

import Foundation

struct Movies: Decodable{
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results:Int
}

struct Movie: Decodable, Identifiable{
    var backdrop_path: String
    var overview: String
    var release_date: String
    var id: Int
    var title: String
    var vote_average: Double
}

