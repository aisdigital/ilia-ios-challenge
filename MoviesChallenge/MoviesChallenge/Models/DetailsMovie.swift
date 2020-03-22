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
    let poster: String
    let runtime: Int
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
