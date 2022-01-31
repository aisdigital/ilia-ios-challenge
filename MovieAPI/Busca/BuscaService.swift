//
//  BuscaService.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 27/01/22.
//

import UIKit
import Alamofire

class BuscaService {
    
    private var movies: [MoviesItens] = []
    static let shared = BuscaService()
    
    var updateLayout: (() -> Void)?
    var shoulError: (() -> Void)?
    
    func buscaMovie (texto: String) {
        
        AF.request("https://api.themoviedb.org/3/search/movie", method: .get).responseJSON { (response) in
            debugPrint("==> Response: ", response)
            guard let data = response.data else {return}
            
            do {
                let moviesModel = try JSONDecoder().decode(MovieModel.self, from: data)
                self.movies = moviesModel.results ?? []
                self.updateLayout?()
                
            } catch (let error) {
                self.shoulError?()
            }
            
        }
        
    }
}
