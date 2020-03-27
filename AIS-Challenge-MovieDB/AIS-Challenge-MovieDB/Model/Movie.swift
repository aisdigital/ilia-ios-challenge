//
//  Movie.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let adult: Bool?
    let backgroundPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backgroundPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(
        adult: Bool?,
        backgroundPath: String?,
        genreIds: [Int]?,
        id: Int?,
        originalLanguage: String?,
        originalTitle: String?,
        overview: String?,
        popularity: Double?,
        posterPath: String?,
        releaseDate: String?,
        title: String?,
        video: Bool?,
        voteAverage: Double?,
        voteCount: Int?
    ) {
        self.adult = adult
        self.backgroundPath = backgroundPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
