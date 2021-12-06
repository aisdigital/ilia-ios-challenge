//
//  MovieOverviewViewModel.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 06/12/21.
//

import Foundation
import Moya

class MovieOverviewViewModel {
    
    var storedMovies = [MovieResult]()
    var page = 1
    let maxPage = 20
    var newIndex: Int = 0
    let imageProvider = MoyaProvider<ImagesAPI>()
    
    func setImageLink(url: String) -> String {
        let url = "https://image.tmdb.org/t/p/w342/\(String(url))"
        return url
    }
    
    func loadImage(url: String, completionHandler: @escaping (Data?) -> Void) {
        imageProvider.request(.imageLink(imageLink: setImageLink(url: url))) {
            (result) in
            switch result {
            case .success(let response):
                let image = response.data
                DispatchQueue.main.async {
                    completionHandler(image)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: date)!
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: s)
        
        return dateString
    }
    
    func getTextColor(average: Double) -> UIColor {
        if average < 4.0 {
            return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        } else if average >= 4.0 && average < 6.0 {
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else {
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
    }
}
