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
    
    func getFavoriteMovies() -> [MovieResponse] {
        if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: Array<MovieResponse>.self, key: key) {
          return retrievedCodableObject
        } else {
            return []
        }
    }
    
    func saveFavoriteMovie(movie: MovieResponse) {
    
    }
    
    func deleteFavoriteMovie(movie: MovieResponse) {
       
    }
    
    func isFavoriteMovie(movie: MovieResponse) -> Bool {
       return true
    }
}
