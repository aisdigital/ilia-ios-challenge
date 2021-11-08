//
//  MovieDetailsViewModel.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 08/11/21.
//


import Foundation

class MovieDetailsViewModel {
    var movieId = Observable<Int>(value: 0)
    var photoUrl = Observable<String>(value: "")
    var title = Observable<String>(value: "")
    var releaseDate = Observable<String>(value: "")
    var voteAverage = Observable<Double>(value: 0)
    var isAdult = Observable<Bool>(value: false)
    private let baseAPIURL = "https://api.themoviedb.org/3/movie"
    private let urlSession = URLSession.shared
    
    init(with movieId:Int) {
 
    }
}

