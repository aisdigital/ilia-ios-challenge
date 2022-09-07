//
//  MoviesRepositoryMock.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import Foundation

class MoviesRepositoryMock: MoviesRepositoryProtocol {
    var isSuccess = true
    
    /*
     @CHANGE
     the following method has been changed to conform to the new signature of MoviesRepositoryProtocol
     */
    func getUpcomingMovies(page: Int) async throws -> MoviesDataResponse {
        return try await withCheckedThrowingContinuation({
            (continuation: CheckedContinuation<MoviesDataResponse, Error>) in
            if isSuccess {
                let user = try! JSONDecoder().decode(MoviesDataResponse.self, from: JSON.loadJSONFromBundle(bundle: Bundle.main, resourceName: "MoviesJSONMock"))
                continuation.resume(returning: user)
            } else {
                continuation.resume(throwing: NSError(domain:"", code: 101, userInfo:nil))
            }
        })
    }
}
