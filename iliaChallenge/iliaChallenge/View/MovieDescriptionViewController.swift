//
//  MovieDescriptionViewController.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 30/10/21.
//

import UIKit
import Alamofire

class MovieDescriptionViewController: UIViewController  {
    
    var movieId = Int()
    var movieDetails = MovieDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesDetails()
        // Do any additional setup after loading the view.
    }
    
    private func getMoviesDetails() {
         AF.request("https://api.themoviedb.org/3/movie/\(movieId)?api_key=f13794b05602015b7f895fed45d8e8f7").validate().responseJSON { response in
             print(response)
             guard response.error == nil else {
                 let alert = UIAlertController(title: "Erro", message: "Algo errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                     alert.dismiss(animated: true)
                 }))
                 self.present(alert, animated: true)
                 return
             }
             
             do {
                 if let data = response.data {
                     print(data)
                     let models = try JSONDecoder().decode(MovieDetails.self, from: data)
                     self.movieDetails = models
                     //print(models)
                 }
             } catch {
                 print("Error during JSON serialization: \(error)")
             }
         }
     }

}
