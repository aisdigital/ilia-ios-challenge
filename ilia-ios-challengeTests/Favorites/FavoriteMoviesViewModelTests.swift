//
//  FavoriteMoviesViewModelTests.swift
//  ilia-ios-challengeTests
//
//  Created by Joao Paulo on 10/04/22.
//

import XCTest
@testable import ilia_ios_challenge

class FavoriteMoviesViewModelTests: XCTestCase {
    
    var favoriteMoviesViewModel: FavoriteMoviesViewModel!
    
    override func setUpWithError() throws {
        let favoritesRepository = FavoritesRepositoryMock(movies: [])
        favoriteMoviesViewModel = FavoriteMoviesViewModel(favoriteMoviesRepository: favoritesRepository)
    }

    override func tearDownWithError() throws {
        
    }
    
    func testSaveFavoriteMovie() {
        let expectedMovie = MovieMock()
        
        favoriteMoviesViewModel.saveFavoriteMovie(movie: expectedMovie)
        favoriteMoviesViewModel.loadFavoriteMovies()
        
        let favoritedMovie = favoriteMoviesViewModel.favoriteMovies.first
        XCTAssertEqual(expectedMovie.title, favoritedMovie?.title)
    }
    
    func testDeleteFavoriteMovie() {
        let expectedMovie = MovieMock()
        let favoritesRepository = FavoritesRepositoryMock(movies: [expectedMovie])
        
        favoriteMoviesViewModel = FavoriteMoviesViewModel(favoriteMoviesRepository: favoritesRepository)
        favoriteMoviesViewModel.loadFavoriteMovies()
        
        favoriteMoviesViewModel.deleteFavoriteMovie(movie: expectedMovie)
        favoriteMoviesViewModel.loadFavoriteMovies()
        
        let isFavoriteMovie = favoriteMoviesViewModel.favoriteMovies.contains { $0.title ==  expectedMovie.title }
        
        XCTAssertFalse(isFavoriteMovie)
    }
    
    func testLoadFavoriteMovies() async {
        let movie1 = MovieMock()
        let movie2 = MovieMock()
        let expectedCount = 2
        
        let favoritesRepository = FavoritesRepositoryMock(movies: [movie1, movie2])
        
        favoriteMoviesViewModel = FavoriteMoviesViewModel(favoriteMoviesRepository: favoritesRepository)
        favoriteMoviesViewModel.loadFavoriteMovies()
        
        let favoriteMoviesCount = favoriteMoviesViewModel.favoriteMovies.count
        XCTAssertEqual(expectedCount, favoriteMoviesCount)
    }
}
