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
    
    /*
     @INSERTION
     This property has been added to viewModel in order to configure the empty title of the view
     */
    var emptyTitle: String {
        "Não há filmes"
    }
    
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
    
    /*
     @INSERTION
     This function has been inserted to handle when the user clicks on favorite button
     */
    func handleFavoriteClick(with movie: MovieResponse) {
        if isFavoriteMovie(movie: movie) {
            deleteFavoriteMovie(movie: movie)
        } else {
            saveFavoriteMovie(movie: movie)
        }
    }
    
    /*
     @INSERTION
     This function has been inserted to check if has favorite movies and change the screen
     */
    func hasMovies() -> Bool {
        !favoriteMovies.isEmpty
    }
}
