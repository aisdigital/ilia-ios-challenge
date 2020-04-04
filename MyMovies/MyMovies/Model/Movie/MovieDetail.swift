//
//  MovieDetail.swift
//  MyMovies
//
//  Created by Wesley Brito on 02/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case id =               "id"
        case title =            "title"
        case overview =         "overview"
        case backdropPath =     "backdrop_path"
        case posterPath =       "poster_path"
        case releaseDate =      "release_date"
        case runtime =          "runtime"
        case voteAverage =      "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
    }
}
