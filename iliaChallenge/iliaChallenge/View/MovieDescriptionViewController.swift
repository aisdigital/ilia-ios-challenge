//
//  MovieDescriptionViewController.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 30/10/21.
//

import UIKit
import Alamofire

class MovieDescriptionViewController: UIViewController  {
    
    public let overview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Overview"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .left
        return label
    }()
    
    public let movieOverView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.baselineAdjustment = .alignBaselines
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .left
        return label
    }()
    
    //var photo = UIImage()
    //var imageView = UIImageView()
    var movieId = Int()
    var movieDetails = MovieDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getMoviesDetails()

        //imageView.contentMode = .scaleAspectFit
        //imageView = UIImageView(image: photo)
        //view.addSubview(imageView)
        view.addSubview(overview)
        view.addSubview(movieOverView)
        
        setupConstraints()
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

                     let models = try JSONDecoder().decode(MovieDetails.self, from: data)
                     self.movieDetails = models
                     self.movieOverView.text = self.movieDetails.overview
                     self.navigationItem.title = self.movieDetails.title
                 }
             } catch {
                 print("Error during JSON serialization: \(error)")
             }
         }
        
        
        /*
        let imagePAth = self.movieDetails.backdropPath ?? ""
        var imageUrl = URL("https://www.themoviedb.org/t/p/original/" + imagePAth
        AF.download(imageUrl).responseData { response in
            switch response.result {
            case .success(let data):
                
                self.photo = UIImage(data: data)!

            default:
                break
            }
        }*/
     }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            overview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            overview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
           
        ])
        
        NSLayoutConstraint.activate([
            movieOverView.topAnchor.constraint(equalTo: overview.bottomAnchor ,constant: 16),
            movieOverView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            movieOverView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    
    }

}
