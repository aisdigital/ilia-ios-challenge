//
//  ServiceRepository.swift
//  MyMovies
//
//  Created by Wesley Brito on 02/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation

class ServiceRepository {
    static let baseUrl: String = getPlist(variable: "url")
    static let API: String = getPlist(variable: "API")
    static let language: String = getPlist(variable: "language")
    static let movie: String = getPlist(variable: "movie")
    static let movieNowPlaying: String = getPlist(variable: "movieNowPlaying")
    static let movieUpcoming: String = getPlist(variable: "movieUpcoming")
    static let series: String = getPlist(variable: "series")
    static let seriesOnTheAir: String = getPlist(variable: "seriesOnTheAir")
    static let seriesAiringToday: String = getPlist(variable: "seriesAiringToday")
    static let topRated: String = getPlist(variable: "topRated")
    static let popular: String = getPlist(variable: "popular")
    static let season: String = getPlist(variable: "season")
    
    
    //movieURL
    static func movieUrl(page: Int) -> String {
        let url =
                "\(baseUrl)" +
                "\(movie)" +
                "\(popular)" +
                "\(API)" +
                "\(language)" +
                "&page=\(page)"
        return url
    }
    
    //serieURL
    static func serieUrl(page: Int) -> String {
        let url =
                "\(baseUrl)" +
                "\(series)" +
                "\(popular)" +
                "\(API)" +
                "\(language)" +
                "&page=\(page)"
        return url
    }
    
    //movieDetail
    static func movieDetailUrl(movieId: Int) -> String {
        let url =
            "\(baseUrl)" +
                "\(movie)" +
                "/\(movieId)" +
                "\(API)" +
                "\(language)"
        return url
    }
    
    //seriesDetail
    static func seriesDetailUrl(serieId: Int) -> String {
        let url =
            "\(baseUrl)" +
                "\(series)" +
                "/\(serieId)" +
                "\(API)" +
                "\(language)"
        return url
    }
    
    //seriesEpisodesUrl
    static func seriesEpisodesUrl(serieId: Int, seasonNumber: Int) -> String {
        let url =
            "\(baseUrl)" +
                "\(series)" +
                "/\(serieId)" +
                "\(season)" +
                "/\(seasonNumber)" +
                "\(API)" +
                "\(language)"
        return url
    }
    
    class func getPlist(variable: String) -> String {
        return get(variable: variable)[variable] ?? ""
    }
    
    class func get(variable: String) -> [String : String] {
        if let url = Bundle.main.url(forResource: "service", withExtension: "plist"),
            let values = NSDictionary(contentsOf: url) as? [String:String] {
            return values
        }
        print("PLIST Error")
        return [:]
    }
}


//poster images
//"poster_sizes": [
//"w92",
//"w154",
//"w185",
//"w342",
//"w500",
//"w780",
//"original"
//],
