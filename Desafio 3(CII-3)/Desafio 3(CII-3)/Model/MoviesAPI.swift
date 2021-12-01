//
//  MoviesFunctions.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit

class MoviesAPI {
    var storedMovies = [Result]()
    var page = 1
    let maxPage = 20
    var newIndex: Int = 0
    let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=0d959db44c2b30eb348d0dc5be5cc1ad&language=en-US&page="

    func fetchData(url: String, completionHandler: @escaping (Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "\(url)\(page)")!)){
            (urlData, req, error) in
            do{
                let result = try JSONDecoder().decode(Movie.self, from: urlData!)
                DispatchQueue.main.async {
                    self.storedMovies = result.results
                    completionHandler(error)
                }
            }catch let jsonError as NSError{
                print("error: \(jsonError.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func setImageLink(url: String) -> String {
        let url = "https://image.tmdb.org/t/p/w342/\(String(url))"
        return url
    }
    
    func loadImage(url: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: setImageLink(url: url))!)) {
            (data, res, error) in
            guard let datas = data else {
                completionHandler(nil, error)
                return
            }
            DispatchQueue.main.async {
                completionHandler(datas, nil)
            }
        }
        task.resume()
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: date)!
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: s)
        
        return dateString
    }
    
    func setTextColor(average: Double) -> UIColor {
        if average < 4.0 {
            return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        } else if average >= 4.0 && average < 6.0 {
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else {
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
    }
}
