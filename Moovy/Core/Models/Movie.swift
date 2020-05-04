//
//  Movie.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 02/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    let adult: Bool
    let releaseDate: String?
    let voteAverage: Double
    let totalVotes: Int
    let runtime: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, adult, runtime
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case totalVotes = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        adult = try container.decode(Bool.self, forKey: .adult)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        totalVotes = try container.decode(Int.self, forKey: .totalVotes)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
    }
}

extension Movie: ParseDelegate {
    typealias ParseModel = Movie
}
