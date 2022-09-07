//
//  MovieMock.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import Foundation

class MovieMock: MovieResponse {
    init() {
        /*
         @CHANGE
         the init has been changed to conform to the new initializer
         */
        super.init(
            id: 1,
            overview: "overview",
            posterPath: "posterPath",
            releaseDate: "2022-10-31",
            title: "titleTest",
            voteAverage: 0
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
