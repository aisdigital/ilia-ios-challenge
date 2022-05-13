//
//  MoviesRepository.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getUpcomingMovies(page: Int) async throws -> [MovieResponse]
}

class MoviesRepository: MoviesRepositoryProtocol {
    var movieProvider: MovieProvider
    
    init(movieProvider: MovieProvider){
        self.movieProvider = movieProvider
    }
    
    func getUpcomingMovies(page: Int) async throws -> [MovieResponse] {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<[MovieResponse], Error>) in movieProvider.provider.request(.upcomingMovies(page: page)) { result in
                switch result {
                case .success(let response):
                    let user = try! JSONDecoder().decode(MoviesDataResponse.self, from: response.data)
                    let moviesResult = user.results
                    continuation.resume(returning: moviesResult)
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}
