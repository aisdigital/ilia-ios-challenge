//
//  MovieTrailer.swift
//  MyMovies
//
//  Created by Wesley Brito on 03/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Welcome
struct MovieTrailer: Decodable {
    let id: Int
    let results: [MovieTrailerKey]
}

// MARK: - Result
struct MovieTrailerKey: Decodable {
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case key
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key) ?? ""
    }
}
