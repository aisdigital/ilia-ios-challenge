//
//  NetworkDispatcher.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Quem manda as requisições e recebe as respostas
struct NetworkDispatcher {
    // MARK: - Constants

    /// O framework que permite fazer requisiç~ioes
    let urlSession: URLSession!

    // MARK: - Init

    /// Inicializador da estrutura
    /// - Parameters:
    ///   - urlSession: Sessão de requisições
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    // MARK: - Public Methods

    /// Dispatch  um URLRequest e retorna um publisher
    /// - Parameter request: URLRequest
    /// - Returns: Um publisher que já decoda a resposta ou retorna um erro
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        return self.urlSession
            .dataTaskPublisher(for: request)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse {
                    if !(200...299).contains(response.statusCode) {
                        throw httpError(response.statusCode)
                    }
                }

                return data
            })
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { error in
                self.handleError(error)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Private Methods

extension NetworkDispatcher {
    /// Parsea o código de erro HTTP recebido
    /// - Parameter statusCode: Código de status HTTP
    /// - Returns: Erro mapeado
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }

    /// Parsea o erro do publisher do URLSession e retorna um erro descrito
    /// - Parameter error: Erro do publisher URLSession
    /// - Returns: Um erro mais compressível
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}
