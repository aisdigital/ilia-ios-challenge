//
//  MovieResponse.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation

class MovieResponse: Codable {
    /*
     @INSERTION
     The id: Int property has been inserted to manage favorite movies
     */
    let id: Int?
    /*
     @DELETION
     The following properties have been deleted as they are not used and do not need to be in the model
     let adult: Bool?
     let originalLanguage: String?
     let originalTitle: String?
     let popularity: Double?
     */
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        /*
         @INSERTION
         Esse case foi inserido por conta da nova propriedade id: Int no model
         */
        case id
        /*
         @DELETION
         The following cases have been deleted as they are not being used
         case adult
         case originalLanguage = "original_language"
         case originalTitle = "original_title"
         case overview, popularity
         */
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }

    /*
     @CHANGE
     The initializer was changed to receive only the parameters that will be used and insert the new parameter id
     */
    init(id: Int, overview: String, posterPath: String, releaseDate: String, title: String, voteAverage: Double) {
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }
}
