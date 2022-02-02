//
//  BuscaService.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 27/01/22.
//

import UIKit
import Alamofire

struct ConstantSearch {
    static let Api_Key = "52db72946dc3afe5a87fe0ab69aec074"
    static let baseURL = "https://api.themoviedb.org"
}

class BuscaService {
    // ("\(ConstantSearch.baseURL)/3/search/movie?api_key=\(ConstantSearch.Api_Key)&query=\(texto)")
    private var movies: [MoviesItens] = []
    static let shared = BuscaService()
    
    var updateLayout: (() -> Void)?
    var shoulError: (() -> Void)?
    
    func buscaMovie (texto: String) {
        guard let texto = texto.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(ConstantSearch.baseURL)/3/search/movie?api_key=\(ConstantSearch.Api_Key)&query=\(texto)") else {
            return
            
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieModel.self, from: data)
//                completion(.success(results.results))
            } catch {
//                completion(.failure(results.results))
            }
        }
        task.resume()
    }
}
