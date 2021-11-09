//
//  SignInRequest.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Request para nos logar
struct SignInRequest: Request {
    // MARK: - Request

    typealias ReturnType = SignInResponse

    var method: HTTPMethod = .post
    var path: String = "/authentication/token/validate_with_login"
    var queryParams: [String : String]?
    var body: [String : Any]?
    var contentType: String = "application/json"

    // MARK: - Init

    /// Inicializador da estrutura
    /// - Parameters:
    ///   - username: email
    ///   - password: senha
    ///   - requestToken: Token
    init(username: String, password: String, requestToken: String) {
        self.queryParams = ["api_key": AppConstants.apiKey]
        self.body = ["username": username, "password": password, "request_token": requestToken]
    }
}
