//
//  DetailsMovie.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import Foundation

struct DetailsMovie: Decodable {
    let title: String
    let description: String
    let poster: String?
    let runtime: Int
    let genres: [Genre]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "overview"
        case poster = "poster_path"
        case genres
        case runtime
        case date = "release_date"
    }
    
    func getImagePoster() -> URL? {
        guard let poster = poster else { return nil }
        return URL(string: API.urlBaseImageBig + poster)
    }
    
    func getDate() -> String {
        return Utils.getFormattedDate(dateString: date)
    }
    
    func  getRuntime() -> String {
        return Utils.getTimeMove(runtime: runtime)
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
