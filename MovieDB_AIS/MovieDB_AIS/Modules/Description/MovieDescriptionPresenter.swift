//  
//  MovieDescriptionPresenter.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import Foundation

protocol MovieDescriptionPresenterDelegate: BasePresenterDelegate {
}

class MovieDescriptionPresenter {
    
    weak var delegate: MovieDescriptionPresenterDelegate?
    
    init(delegate: MovieDescriptionPresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
    }
}
