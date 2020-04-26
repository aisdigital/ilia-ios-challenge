//
//  MovieDAO.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 25/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import Moya

class MovieDAO {
    static func getMovies(with page:Int,
                          success: @escaping (([MovieObject]) -> Void),
                          failure: @escaping ((String) -> Void)) {
        let provider = MoyaProvider<MovieTarget>()
        
        provider.request(.getAll(page: page), completion: { result in
            switch result {
            case .success(let response):
                print("RESPONSE_SUCCESS: [\n \(try? response.mapString())\n]")
                guard let dict = try? response.map(ResultObject<MovieObject>.self),
                    dict.total_pages != page else {
                    return
                }
                success(dict.results)
            case .failure(let responseError):
                print("RESPONSE_FAILURE: [\n \(try? responseError.response?.mapString())\n]")
                failure(ErrorMessages.generic.localized())
            }
        })
    }
    
    static func searchMovies(with title: String,
                             and page: Int,
                             success: @escaping (([MovieObject]) -> Void),
                             failure: @escaping ((String) -> Void)) {
        let provider = MoyaProvider<MovieTarget>()
        
        provider.request(.search(movieTitle: title, page: page), completion: { result in
            switch result {
            case .success(let response):
                print("RESPONSE_SUCCESS: [\n \(try? response.mapString())\n]")
                guard let dict = try? response.map(ResultObject<MovieObject>.self),
                    dict.total_pages != page else {
                    return
                }
                success(dict.results)
            case .failure(let responseError):
                print("RESPONSE_FAILURE: [\n \(try? responseError.response?.mapString())\n]")
                failure(ErrorMessages.generic.localized())
            }
        })
    }
}
