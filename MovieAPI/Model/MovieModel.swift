//
//  MovieModel.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 25/01/22.
//

//https://www.youtube.com/watch?v=9InccoI9kQA

import Foundation

struct MovieModel: Codable {
    let results: [MoviesItens]
}

struct MoviesItens: Codable {
    let title: String
    let poster_path: String?
    let overview: String
    let id: Int
//    let popularity: Int
    let vote_average: String
    let release_date: String
    let vote_count: Int
}


