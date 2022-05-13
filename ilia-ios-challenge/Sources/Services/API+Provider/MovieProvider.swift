//
//  MovieProvider.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//
import Moya

class MovieProvider {
    var provider: MoyaProvider<MovieAPI>!
    
    init(isStub: Bool = false) {
        self.provider = isStub ? MoyaProvider<MovieAPI>(stubClosure: MoyaProvider.immediatelyStub) : MoyaProvider<MovieAPI>()
    }
}
