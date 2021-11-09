//
//  Request.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Protocolo dos requests
public protocol Request {
    /// Path que vem depois do URL
    var path: String { get set }
    /// Methodo de consulta
    var method: HTTPMethod { get }
    /// Tipo de conteúdo da requisição
    var contentType: String { get }
    /// Parâmetros de consulta
    var queryParams: [String: String]? { get set }
    /// Body do request se tem
    var body: [String: Any]? { get set }
    /// Headers do request se tem
    var headers: [String: String]? { get }

    /// Resposta do request
    associatedtype ReturnType: Codable
}

/// Valores default
extension Request {
    var method: String { return HTTPMethod.get.rawValue }
    var contentType: String { return "application/json" }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

extension Request {
    /// Serializa o corpo da mensagem. Usado para a autenticação
    /// - Parameter params: Parâmetros
    /// - Returns: JSON encodado
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    /// Transforma um request em um URLRequest usado pelo URLSession
    /// - Parameter baseURL: URL base
    /// - Returns: O request já formatado
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        
        urlComponents.path = "\(urlComponents.path)\(self.path)"

        var queryItems: [URLQueryItem] = []

        if let queryParams = self.queryParams {
            for (queryKey, queryValue) in queryParams {
                queryItems.append(URLQueryItem(name: queryKey, value: queryValue))
            }
        }

        urlComponents.queryItems = queryItems

        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)

        request.setValue("\(self.contentType); charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("\(self.contentType); charset=utf-8", forHTTPHeaderField: "Accept")

        request.httpMethod = self.method.rawValue
        request.httpBody = self.requestBodyFrom(params: self.body)
        request.allHTTPHeaderFields = self.headers
        return request
    }
}
