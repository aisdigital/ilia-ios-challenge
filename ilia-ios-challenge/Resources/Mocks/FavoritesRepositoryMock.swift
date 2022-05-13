//
//  FavoritesRepositoryMock.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import Foundation

class FavoritesRepositoryMock: FavoritesRepositoryProtocol {
    var movies: [MovieResponse] = []
    
    init(movies: [MovieResponse]) {
        self.movies = movies
    }
    
    func getFavoriteMovies() -> [MovieResponse] {
        return movies
    }
    
    func saveFavoriteMovie(movie: MovieResponse) {
        movies.append(movie)
    }
    
    func deleteFavoriteMovie(movie: MovieResponse) {
        movies = movies.filter { $0.title != movie.title }
    }
    
    func isFavoriteMovie(movie: MovieResponse) -> Bool {
        return movies.contains { $0.title == movie.title }
    }
}
