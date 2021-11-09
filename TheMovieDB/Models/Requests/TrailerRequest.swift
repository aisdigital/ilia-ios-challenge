//
//  TrailerRequest.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Request do trailer
struct TrailerRequest: Request {
    // MARK: - Request

    typealias ReturnType = TrailerResponse

    var method: HTTPMethod = .get
    var path: String = ""
    var queryParams: [String : String]?
    var body: [String : Any]?
    var contentType: String = "application/json"

    // MARK: - Init

    /// Inicializador da estrutura
    /// - Parameters:
    ///   - movieID: ID do filme
    ///   - language: Idioma do trailer
    init(movieID: Int, language: String = "pt-BR") {
        self.path = "/movie/\(movieID)/videos"
        self.queryParams = ["api_key": AppConstants.apiKey, "language": language]
    }
}
