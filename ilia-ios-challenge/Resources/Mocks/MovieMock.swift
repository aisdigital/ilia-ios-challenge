//
//  MovieMock.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import Foundation

class MovieMock: MovieResponse {
    init() {
        super.init(
            adult: true,
            backdropPath: "",
            genreIDS: [],
            originalLanguage: "originalLanguage",
            originalTitle: "originalTitle",
            overview: "overview",
            popularity: 0,
            posterPath: "posterPath",
            releaseDate: "2022-10-31",
            title: "titleTest",
            video: true,
            voteAverage: 0,
            voteCount: 0
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
