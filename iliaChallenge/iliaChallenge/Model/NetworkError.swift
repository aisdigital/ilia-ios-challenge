//
//  NetworkError.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 30/10/21.
//

import Foundation

import Foundation

enum NetworkError: String, Error {
    case invalidResponse = "Resposta inválida do servidor ou não foi possível concluir sua solicitação. Por favor verifique sua conexão com a internet e tente novamente."
    case invalidData = "Os dados recebidos do servidor eram inválidos. Por favor, tente novamente."
    case failedToDecodeResponse = "Incapaz de decodificar a resposta. Por favor, tente novamente."
}
