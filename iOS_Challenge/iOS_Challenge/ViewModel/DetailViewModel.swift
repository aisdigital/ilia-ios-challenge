//
//  DetailViewModel.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import Foundation
import UIKit

class DetailViewModel {
    
    var name: String!
    var releaseYear: String!
    var overview: String!
    
    init(film: Film) {
        self.name = film.name
        self.releaseYear = film.releaseDate
        self.overview = film.description
    }
}
