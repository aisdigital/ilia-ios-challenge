//
//  MoviesRepository.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getUpcomingMovies(page: Int) async throws -> MoviesDataResponse
}

class MoviesRepository: MoviesRepositoryProtocol {
    var movieProvider: MovieProvider
    
    init(movieProvider: MovieProvider){
        self.movieProvider = movieProvider
    }
    
    /*
     @CHANGE
     the following function changed the return because it needs the pageLimit
     */
    func getUpcomingMovies(page: Int) async throws -> MoviesDataResponse {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<MoviesDataResponse, Error>) in movieProvider.provider.request(.upcomingMovies(page: page)) { result in
                switch result {
                case .success(let response):
                    let user = try! JSONDecoder().decode(MoviesDataResponse.self, from: response.data)
                    continuation.resume(returning: user)
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}
