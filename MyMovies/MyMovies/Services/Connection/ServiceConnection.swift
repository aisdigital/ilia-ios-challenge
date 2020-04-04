//
//  ServiceConnection.swift
//  MyMovies
//
//  Created by Wesley Brito on 02/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation
import Alamofire

class ServiceConnection {
    
    /// Serviço de requisição genérica utilizado para get
    /// - Parameters:
    ///   - url: url da api
    ///   - type: Qual model vai ser feito o parse
    ///   - onCompletion: callback da resposta
    func makeHTTPGetRequest<T:Decodable>(_ url: String,_ type: T.Type, onCompletion: @escaping (T?, RequestErrors?) -> Void) {
        AF.request(url)
            .responseJSON { (response) in
                if let data = response.data {
                    do {
                        let object = try JSONDecoder().decode(type, from: data)
                        DispatchQueue.main.async {
                            onCompletion(object, nil)
                        }
                        return
                    } catch {
                        DispatchQueue.main.async {
                            onCompletion(nil, .unexpectedError)
                        }
                    }
                }
        }
    }
}
