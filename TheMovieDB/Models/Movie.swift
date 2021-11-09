//
//  Movie.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Combine
import Foundation

/// Filme
struct Movie: Codable, Identifiable {
    var id: Int
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double

    /// Formata a quantidade de votos
    /// - Returns: Quantidade de votos formatada
    func movieVoteCountInThousand() -> String {
        let voteCount: Double = (Double(self.vote_count) / 1000.0)
        return "\(Double(round(100.0 * voteCount) / 100))k"
    }

    /// Média de votos formatada
    /// - Returns: Média de votos formatada
    func formatVoteAverage() -> String {
        return "\(Double(round(10.0 * self.vote_average) / 10))"
    }

    /// Retorna um poster preferencial
    /// - Returns: O poster preferencial
    func getPreferencialPoster() -> String? {
        if let poster_path = self.poster_path {
            return poster_path
        }

        if let backdrop_path = backdrop_path {
            return backdrop_path
        }

        return nil
    }

    /// Retorna um poster não preferencial
    /// - Returns: O poster não preferencial
    func getNotPreferencialPoster() -> String? {
        if let backdrop_path = backdrop_path {
            return backdrop_path
        }

        if let poster_path = self.poster_path {
            return poster_path
        }

        return nil
    }
}
