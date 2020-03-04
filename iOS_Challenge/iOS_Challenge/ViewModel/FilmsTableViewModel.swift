//
//  FilmsTableViewModel.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import Foundation
import UIKit


protocol ReloadViewDelegate {
    func reloadView()
}

class FilmsTableViewModel{
    
    var films: [Film]!
    var theMovieAPI: TheMovieServiceAPI!
    
    var viewDelegate: ReloadViewDelegate?
    
    var filmsImage: [UIImage] = [UIImage]()
    
    init() {
        self.theMovieAPI = TheMovieServiceAPI()
        self.theMovieAPI.fetchMovies(page: 1)
        self.theMovieAPI.dataDelegate = self
        self.films = [Film]()
    }
    
    func updateFilms(page: Int){
        self.theMovieAPI.fetchMovies(page: page)
    }
    
    
}

extension FilmsTableViewModel: UpdateDataDelegate{
    func updateData(result: [Film]?) {
        
        if let res = result{
            DispatchQueue.main.sync {
                self.films = res
                self.viewDelegate?.reloadView()
            }
        }
    }
}

extension FilmsTableViewModel: UpdateImageDelegate{
    
    func updateImage(result: UIImage?) {
        if let image = result{
            DispatchQueue.main.sync {
                
            }
        }
    }
    
    
}
