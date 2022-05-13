//
//  HomeMoviesViewModel.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation
import SwiftUI

class HomeMoviesViewModel: ObservableObject {
    var moviesRepository: MoviesRepositoryProtocol
    
    private(set) var movies: [MovieResponse] = []
    
    @State private(set) var state = LoadingState.idle
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    func loadMovies(page: Int) async {
        self.state = .loading
        do {
            self.movies = try await moviesRepository.getUpcomingMovies(page: page)
            self.state = .loaded
        } catch let error {
            self.movies = []
            self.state = .failed(error)
        }
    }
    
    func hasMovies() -> Bool {
        return movies.isEmpty
    }
}
