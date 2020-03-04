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

// MARK: - NowPlaying

struct InTheatres: Codable {
    
    let movies: [MovieBasicInfo]
    let page: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
    }
    
     struct MovieBasicInfo: Codable {
        
        let posterPath: String
        let id: Int
        let title: String
        
        enum CodingKeys: String, CodingKey {
            
            case posterPath = "poster_path"
            case id
            case title
        }
    }
}
