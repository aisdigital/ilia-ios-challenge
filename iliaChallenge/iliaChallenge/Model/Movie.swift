//
//  Movie.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 30/10/21.
//

import Foundation

struct Movie: Codable {
    var page : Int
    var results : [Results]
    var total_pages: Int
    var total_results:Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}

struct Results: Codable {
    var poster_path: String
    var id: Int
    var title: String
    var release_date: String
    
    enum CodingKeys: String, CodingKey {
        case poster_path = "poster_path"
        case id = "id"
        case title = "title"
        case release_date = "release_date"
    }
    
}
