//
//  MovieTarget.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 25/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import Foundation
import Moya

enum MovieTarget {
    case getAll(page: Int)
}

extension MovieTarget: TargetType {
    var baseURL: URL {
        switch self {
        case .getAll(let page):
            return URL(string:"https://api.themoviedb.org/3/discover/movie?api_key=\(AppDelegate.getAPIKey())&language=pt-br&page=\(page)")!
        }
    }
    
    var path: String {
        switch self {
        default: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAll: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAll: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["content-type" : "appliaction/json"]
    }
}
