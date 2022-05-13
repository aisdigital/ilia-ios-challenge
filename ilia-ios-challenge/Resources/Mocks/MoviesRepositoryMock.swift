//
//  MoviesRepositoryMock.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import Foundation

class MoviesRepositoryMock: MoviesRepositoryProtocol {
    var isSuccess = true
    
    func getUpcomingMovies(page: Int) async throws -> [MovieResponse] {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<[MovieResponse], Error>) in
            if isSuccess {
                let user = try! JSONDecoder().decode(MoviesDataResponse.self, from: JSON.loadJSONFromBundle(bundle: Bundle.main, resourceName: "MoviesJSONMock"))
                let moviesResult = user.results
                continuation.resume(returning: moviesResult)
            } else {
                continuation.resume(throwing: NSError(domain:"", code: 101, userInfo:nil))
            }
        })
    }
}
