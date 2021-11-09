//
//  SignInResponse.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Response de tentar criar um token
struct SignInResponse: Codable {
    /// Se a resposta teve sucesso
    var success: Bool?
    /// Quando expira o token
    var expires_at: String?
    /// Token necessário para logarse
    var request_token: String?
}
