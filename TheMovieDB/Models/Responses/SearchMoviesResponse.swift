//
//  SearchMoviesResponse.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Response para buscar filmes
struct SearchMoviesResponse: Codable {
    /// Aba atual
    var page: Int
    /// Filmes
    var results: [Movie]
    /// Total de filmes
    var total_results: Int
    /// Total de abas
    var total_pages: Int
}
