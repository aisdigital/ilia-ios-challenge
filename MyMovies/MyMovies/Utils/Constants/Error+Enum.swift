//
//  Error+Enum.swift
//  MyMovies
//
//  Created by Wesley Brito on 02/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation

enum RequestErrors: String {
    case noInternet
    case unexpectedError
    
    var message: String {
        switch self {
        case .noInternet:
            return "Verifique sua conexão de internet."
        case .unexpectedError:
            return "Erro inesperado, tente novamente."
        }
    }
}
