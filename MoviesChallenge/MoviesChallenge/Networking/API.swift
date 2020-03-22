//
//  API.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct API {
    
    static let urlBaseMovies = "https://api.themoviedb.org/3/movie/"
    static let endPointMovies = "now_playing"
    static let apiKey = "659643b883f3e5aa46a5fc88f1e3f01f"
    static let language = "pt-BR"
    static let urlBaseImage = "http://image.tmdb.org/t/p/w185"
    static let urlBaseImageBig = "http://image.tmdb.org/t/p/w500"
    
    static func getMovies(page: Int) -> Observable<ResultMovies> {
        guard let url = URL(string: "\(urlBaseMovies)\(endPointMovies)?api_key=\(apiKey)&&language=\(language)&page=\(page)")
        else { fatalError("Can't created URL") }
        
        return Observable.create { observer in
            AF.request(url).responseDecodable(of: ResultMovies.self) { (response) in
                switch response.result {
                case .success(let resultMovies):
                    observer.onNext(resultMovies)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    static func getDetailsMovie(id: Int) -> Observable<DetailsMovie> {
        guard let url = URL(string: "\(urlBaseMovies)\(id)?api_key=\(apiKey)&&language=\(language)")
        else { fatalError("Can't created URL") }
        
        return Observable.create({ observer in
            AF.request(url).responseDecodable(of: DetailsMovie.self) { (response) in
                switch response.result {
                case .success(let detailMovie):
                    observer.onNext(detailMovie)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
