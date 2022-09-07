//
//  FavoritesRepository.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import Foundation

protocol FavoritesRepositoryProtocol {
    func getFavoriteMovies() -> [MovieResponse]
    func saveFavoriteMovie(movie: MovieResponse)
    func deleteFavoriteMovie(movie: MovieResponse)
    func isFavoriteMovie(movie: MovieResponse) -> Bool
}


class FavoritesRepository: FavoritesRepositoryProtocol {
    let key: String = "favorite_movies"
    
    /*
     @SUGGESTION
     Maybe here it was better to save only the movie id in order to reduce the size and always fetch updated movies
     */
    func getFavoriteMovies() -> [MovieResponse] {
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: Array<MovieResponse>.self, key: key) {
          return retrievedCodableObject
        } else {
            return []
        }
    }
    
    /*
     @CHANGE
     The following function has been changed to fix the logic of saving favorite movies
     */
    func saveFavoriteMovie(movie: MovieResponse) {
        var movies = getFavoriteMovies()
        
        movies.append(movie)
        
        UserDefaults.standard.setCodableObject(movies, forKey: key)
    }
    
    /*
     @CHANGE
     The following function has been changed to fix the logic of deleting favorite movies
     */
    func deleteFavoriteMovie(movie: MovieResponse) {
        var movies = getFavoriteMovies()
        
        movies = movies.filter({$0.id != movie.id})
        
        UserDefaults.standard.setCodableObject(movies, forKey: key)
    }
    
    /*
     @CHANGE
     The following function has been changed to fix the logic to see if the movie is in the favorites list
     */
    func isFavoriteMovie(movie: MovieResponse) -> Bool {
        getFavoriteMovies().contains(where: {$0.id == movie.id})
    }
}
