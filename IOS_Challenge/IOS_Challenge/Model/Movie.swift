//
//  Movie.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation


//MARK: - Movie Model
struct Movie: Codable {
    
    let adult: Bool
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let productionCompanies: [ProductionCompany]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, title: String
    let voteAverage : Float
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres, id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
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
