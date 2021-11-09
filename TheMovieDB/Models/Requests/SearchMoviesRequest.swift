//
//  SearchMoviesRequest.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Request para buscar filmes
struct SearchMoviesRequest: Request {
    // MARK: - Request

    typealias ReturnType = SearchMoviesResponse

    var method: HTTPMethod = .get
    var path: String = "/search/movie"
    var queryParams: [String : String]?
    var body: [String : Any]?
    var contentType: String = "application/json"

    // MARK: - Init

    /// Inicializador da estrutura
    /// - Parameter searchText: Texto de busca de filmes
    /// - Parameter language: Idioma
    /// - Parameter page: Aba
    /// - Parameter includeAdult: Se vai incluir conteúdo para adultos
    /// - Parameter region: Região
    /// - Parameter year: Ano
    /// - Parameter primaryReleaseYear: Ano onde foi lançado primeiro
    init(searchText: String, language: String = "pt-BR", page: Int = 1, includeAdult: Bool = false, region: String? = nil, year: Int? = nil, primaryReleaseYear: Int? = nil) {
        self.queryParams = ["api_key": AppConstants.apiKey,
                            "query": searchText,
                            "language": language,
                            "page": "\(page)",
                            "include_adult": "\(includeAdult)"]

        if let region = region {
            self.queryParams?["region"] = region
        }

        if let year = year {
            self.queryParams?["year"] = "\(year)"
        }

        if let primaryReleaseYear = primaryReleaseYear {
            self.queryParams?["primary_release_year"] = "\(primaryReleaseYear)"
        }
    }
}
