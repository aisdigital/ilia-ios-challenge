//
//  HomePresenter.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

protocol HomePresenterDelegate: class {
    func getTheatreMovies(page: Int, completion: @escaping completionHandler)
    func getMovieImageURL(path: String) -> String
}

class HomePresenter: HomePresenterDelegate {
    
    weak private var view: HomeDelegate?
    private let service: HomeService
    
    init (service: HomeService) {
        self.service = service
    }
    
    func setView (delegate: HomeDelegate?) {
        self.view = delegate
    }
    
    func setupUI () {
        view?.setupActivityIndicator()
    }
    
    func getTheatreMovies(page: Int, completion: @escaping completionHandler) {
        service.requestTheatersMovies(page: page) {
            (success, message, moviesData) in
            completion(success, message, moviesData)
        }
    }
    
    func getMovieImageURL(path: String) -> String {
        return service.createDownloadableImageURL(path: path)
    }
}
