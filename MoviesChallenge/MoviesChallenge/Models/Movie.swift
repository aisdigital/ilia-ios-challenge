//
//  Movie.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 21/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let vote: Double
    let description: String
    let date: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case vote = "vote_average"
        case description = "overview"
        case date = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    func imagePoster() -> URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: API.urlBaseImageBig + posterPath)
    }
}

struct ResultMovies: Decodable {
    let movies: [Movie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalPages = "total_pages"
    }
}
