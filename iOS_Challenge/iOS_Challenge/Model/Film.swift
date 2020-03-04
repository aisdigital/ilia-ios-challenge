//
//  Film.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import Foundation

class Film {
    var name: String
    var description: String
    var releaseDate: String
    var genre: String
    var imagePath: String
    
    init(name: String, description: String, releaseDate: String, genre: String, imagePath: String) {
        self.name = name
        self.description = description
        self.releaseDate = releaseDate
        self.genre = genre
        self.imagePath = imagePath
    }
}
