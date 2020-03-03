//
//  Movie.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation

struct Movie : Codable{
    
    var id: UUID
    var poster: String
    var title: String
    var voteAverage: Float
    var originalTitle: String
    var originalLanguage: String
    var gender: [UUID]
    var overview: String
    var releaseDate: String
    
    enum CodingKeys : String, CodingKey {
        
        case id
        case poster = "poster_path"
        case title
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case gender
        case overview
        case releaseDate = "release_date"
    }
}

