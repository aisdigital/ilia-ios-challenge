//
//  FavoriteViewModel.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import Foundation

class FavoriteMoviesViewModel: ObservableObject {
    var favoriteMoviesRepository: FavoritesRepositoryProtocol
    @Published private(set) var favoriteMovies: [MovieResponse] = []
    
    init(favoriteMoviesRepository: FavoritesRepositoryProtocol) {
        self.favoriteMoviesRepository = favoriteMoviesRepository
    }
    
    func loadFavoriteMovies() {
        favoriteMovies = favoriteMoviesRepository.getFavoriteMovies()
    }
    
    func saveFavoriteMovie(movie: MovieResponse) {
        favoriteMoviesRepository.saveFavoriteMovie(movie: movie)
    }
    
    func deleteFavoriteMovie(movie: MovieResponse) {
        favoriteMoviesRepository.deleteFavoriteMovie(movie: movie)
    }
    
    func isFavoriteMovie(movie: MovieResponse) -> Bool {
        return favoriteMoviesRepository.isFavoriteMovie(movie: movie)
    }
}
