//
//  MoviesApiMoya.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 01/12/21.
//

import Foundation
import Moya

enum MovieAPI {
    case upcomingMovies(page: Int)
    case popularMovies(page: Int)
}

extension MovieAPI: TargetType {
    
    var API_KEY: String {
            return "0d959db44c2b30eb348d0dc5be5cc1ad"
    }
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .upcomingMovies:
            return "movie/upcoming"
        case .popularMovies:
            return "movie/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .upcomingMovies, .popularMovies:
            return .get
        }
    }
        
    var sampleData: Data {
        switch self {
        case .upcomingMovies:
            return Bundle.loadJSONFromBundle(bundle: Bundle.main, resourceName: "movies")
        default:
            return Data()
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var parameters: [String : Any] {
        switch self {
        case .upcomingMovies(let page):
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY
            parameters["language"] = "en-US"
            parameters["page"] = "\(page)"
            return parameters
        case .popularMovies(let page):
            var parameters = [String:Any]()
            parameters["api_key"] = API_KEY
            parameters["language"] = "pt-BR"
            parameters["page"] = "\(page)"
            return parameters
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

