//
//  Movie.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation


// MARK: - Movie
struct Movie: Codable {
    
    var adult: Bool?
    var genres: [Genre]?
    var id: Int?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var title: String?
    var voteAverage: Double?

    var videos: Videos?

    enum CodingKeys: String, CodingKey {
        case adult
        case genres, id
        case overview, popularity
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case videos
    }
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Videos
struct Videos: Codable {
    var results: [VideoPath]?
}

// MARK: - Result
struct VideoPath: Codable {
    var key: String?
    
    enum CodingKeys: String, CodingKey {
        
        case key
    }
}

// MARK: - InTheatres
struct InTheatres: Codable {
    var movies: [MovieBasicInfo]
    var page : Int
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
    }
}

// MARK: - Dates
struct Dates: Codable {
    var maximum, minimum: String
}

// MARK: - MovieBasicInfo
struct MovieBasicInfo: Codable {
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var posterPath: String?
    var id: Int
    var adult: Bool
    var backdropPath: String?
    var originalLanguage, originalTitle: String
    var genreIDS: [Int]
    var title: String
    var voteAverage: Double
    var overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
