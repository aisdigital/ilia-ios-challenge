//
//  MovieListViewModel.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 07/11/21.
//

import Foundation

class MovieListViewModel: TableViewCompatible {
    var reuseIdentifier: String {
        return "MovieCell"
    }
    var movieViewModels = Observable<[MovieViewModel]>(value: [])
    var error = Observable<Bool>(value: false)
    init() {
        self.populateMovies()
    }
     func populateMovies() {
        Service.shared.fetchMovies { [weak self] (movies, err) in
            if let err = err {
                print("Failed to fetch movies:", err)
                return
            }
            self?.movieViewModels.value = movies?.results.map({return MovieViewModel(movie: $0)}) ?? []
            print(self?.movieViewModels.value[0].title)
            //self?.movies = movies?.results ?? []
           // print(self!.movies[0].title)
           }
    }
}
