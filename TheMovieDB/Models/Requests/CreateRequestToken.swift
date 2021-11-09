//
//  CreateRequestToken.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Request para procurar empresas por nome
struct CreateRequestToken: Request {
    // MARK: - Request

    typealias ReturnType = SignInResponse

    var method: HTTPMethod = .get
    var path: String = "/authentication/token/new"
    var queryParams: [String : String]?
    var body: [String : Any]?
    var contentType: String = "application/json"

    // MARK: - Init

    /// Inicializador da estrutura
    init() {
        self.queryParams = ["api_key": AppConstants.apiKey]
    }
}
