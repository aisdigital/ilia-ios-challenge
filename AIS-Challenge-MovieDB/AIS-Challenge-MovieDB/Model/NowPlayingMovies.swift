//
//  nowPlayingMovies.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import Foundation

struct NowPlayingMovies: Decodable {
    //let dates: [String]
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        //case dates = "dates"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(
        //dates: [String],
        page: Int?,
        results: [Movie]?,
        totalPages: Int?,
        totalResults: Int?
    ) {
        //self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
