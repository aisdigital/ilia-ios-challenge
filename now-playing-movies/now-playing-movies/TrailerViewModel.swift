//
//  TrailerViewModel.swift
//  now-playing-movies
//
//  Created by iris on 05/11/21.
//

import Foundation
import SwiftUI
import Combine

class TrailerViewModel: ObservableObject {
    
    private var task: AnyCancellable?
    
    @Published var trailer: Trailer = Trailer(key: "")
    @Published var idMovie: Int = 0
    
    
    func fetchTrailer() {
        
        let baseUrl = "https://api.themoviedb.org/3/movie/\(idMovie)/videos?api_key=a710326a9ab261da6dd081d0e5bce81f&language=en-US"
        guard let url = URL(string: baseUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {return}
            if let err = error {
                print("Erro to consume", err)
            }
            do {
                let videos = try JSONDecoder().decode(Videos.self, from: data)
                
                DispatchQueue.main.async {
                    self.trailer.key = videos.results[0].key
                }
                
            } catch let error {
                print("Fail in consume", error)
            }
        }.resume()
    }
}
