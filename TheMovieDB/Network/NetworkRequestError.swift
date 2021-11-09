//
//  NetworkRequestError.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Erros das requisições
enum NetworkRequestError: LocalizedError, Equatable {
    /// Request inválido
    case invalidRequest
    /// Request mal feito
    case badRequest
    /// Não auttorizado
    case unauthorized
    /// Forbidden
    case forbidden
    /// Não encontrado
    case notFound
    /// Error com um código 400 e algo
    case error4xx(_ code: Int)
    /// Error do server
    case serverError
    /// Error com um código 500 e algo
    case error5xx(_ code: Int)
    /// Error ao decodar
    case decodingError
    /// URL Session caiu
    case urlSessionFailed(_ error: URLError)
    /// Error desconhecido
    case unknownError
}
