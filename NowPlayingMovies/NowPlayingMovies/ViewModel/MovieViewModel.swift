//
//  MovieViewModel.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 06/11/21.
//

import Foundation

class MovieViewModel {
    let movieId: Int

    var adult: Bool = false
    var overview = ""
    var releaseDate: String = ""
    var originalTitle: String = ""
    var title: String = ""
    var voteAverage: Double = 0
    

    init(movie :Movie){
        self.movieId = movie.id
        self.adult = movie.adult
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.originalTitle = movie.originalTitle
        self.title = movie.title
        self.voteAverage = movie.voteAverage
    }
}
