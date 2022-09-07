//
//  MoviesDataResponse.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation

/*
 @CHANGE
 removing unused properties such as:
 DatesResponse
 page
 totalResults
 */
class MoviesDataResponse: Codable {
    let results: [MovieResponse]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }

    init(results: [MovieResponse], totalPages: Int) {
        self.results = results
        self.totalPages = totalPages
    }
}
