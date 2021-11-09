//
//  APIClient.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// API que vamos usar para nos comunicar com o servidor
struct APIClient {
    // MARK: - Properties

    /// URL base
    var baseURL: String!
    /// Dispatcher da conexão com o server
    var networkDispatcher: NetworkDispatcher!

    // MARK: - Init

    /// Inicializador da estrutura
    /// - Parameters:
    ///   - baseURL: URL base
    ///   - networkDispatcher: Dispatcher da conexão com o server
    init(baseURL: String, networkDispatcher: NetworkDispatcher = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }
    
    // MARK: - Methods

    /// Dispatcha o Request e retorna um publisher
    /// - Parameter request: Request para o Dispatch
    /// - Returns: Um publisher que já decoda a resposta ou retorna um erro
    func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<R.ReturnType, NetworkRequestError>
        let requestPublisher: RequestPublisher = self.networkDispatcher.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}
