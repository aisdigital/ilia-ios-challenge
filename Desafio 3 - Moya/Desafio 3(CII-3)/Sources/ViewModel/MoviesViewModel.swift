//
//  MoviesViewModel.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Daniel Fernandes da Silva on 03/12/21.
//

import Foundation

class MoviesViewModel {
    let title: String
    let imagePath: String
    
    init(movieData: MovieResult) {
        self.title = movieData.title ?? ""
        self.imagePath = movieData.posterPath ?? ""
    }
}
