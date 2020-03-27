//
//  HomeService.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import Foundation

protocol HomeService: class {
    func requestTheatersMovies(page: Int, completion: @escaping completionHandler)
    func createDownloadableImageURL(path: String) -> String
}

class HomeServiceImplementation: HomeService {
    private let request: Requester = Requestion()
    
    func requestTheatersMovies(page: Int, completion: @escaping completionHandler) {
        request.createRequest(movieDBPaths.nowPlaying, page: page) {
            (success, message, moviesData) in
            completion(success, message, moviesData)
        }
    }
    
    func createDownloadableImageURL(path: String) -> String {
        return request.createImageURL(path: path)
    }
}
