//
//  FilmsTableViewModel.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import Foundation
import UIKit

class FilmsTableViewModel{
    
    var films: [Film]{
        didSet{
            self.filmsImage = [UIImage]()
            for film in films{
                self.filmsImage.append(NetworkUtils.loadImage(imagePath: film.imagePath))
            }
        }
    }
    
    var filmsImage: [UIImage] = [UIImage]()
    var theMoviesApi: TheMovieServiceAPI
    
    init() {
        self.theMoviesApi = TheMovieServiceAPI()
        self.films = theMoviesApi.fetchMovies(page: 1)
    }
    
    func updateFilms(page: Int){
        films = theMoviesApi.fetchMovies(page: page)
    }
    
    
}
