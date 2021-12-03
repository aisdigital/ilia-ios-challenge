//
//  ImagesAPIMoya.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Daniel Fernandes da Silva on 02/12/21.
//

import Foundation
import Moya

enum ImagesAPI {
    case imageLink(imageLink: String)
}

extension ImagesAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .imageLink:
            return URL(string: "https://image.tmdb.org/t/p/w342")!
        }
    }
    
    var path: String {
        switch self {
        case .imageLink(let link):
            return "\(link)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .imageLink:
            return .get
        }
    }
    
    var task: Task {
        let parameters = [String : Any]()
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
