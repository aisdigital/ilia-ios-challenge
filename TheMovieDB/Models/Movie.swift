//
//  Movie.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Combine
import Foundation

/// Um filme
struct Movie: Codable, Identifiable {
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double

    func movieVoteCountInThousand() -> String {
        let voteCount: Double = (Double(self.vote_count) / 1000.0)
        return "\(Double(round(100.0 * voteCount) / 100))k"
    }

    func formatVoteAverage() -> String {
        return "\(Double(round(10.0 * self.vote_average) / 10))"
    }
}
