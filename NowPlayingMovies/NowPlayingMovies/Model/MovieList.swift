//
//  MovieList.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 07/11/21.
//

import Foundation

struct MovieList: Codable {
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }
}
