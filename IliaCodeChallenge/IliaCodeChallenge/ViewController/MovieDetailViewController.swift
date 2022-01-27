//
//  MovieDetailViewController.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 27/01/22.
//

import UIKit

class MovieDetailViewController: ViewController {

    @IBOutlet weak var ivDetailPoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    let movieDet: Movie
    
    init(selectedMovie: Movie){
        movieDet = selectedMovie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        
        lblMovieTitle.text = movieDet.original_title
        
        guard let urlImage = movieDet.backdrop_path else {return}
        if let url = URL(string: "https://image.tmdb.org/t/p/original/\(urlImage)"){
            if let data = try? Data(contentsOf: url){
                let image = UIImage(data: data)
                ivDetailPoster?.image = image
            }
        }
            
        lblMovieOverview?.text = movieDet.overview
    }
    
    func setUpModel(_ movie: Movie?) {
        guard let movieModel = movie else{return}
        lblMovieTitle?.text = movieModel.original_title
        
        guard let urlImage = movie?.backdrop_path else {return}
        if let url = URL(string: "https://image.tmdb.org/t/p/original/\(urlImage)"){
            if let data = try? Data(contentsOf: url){
                let image = UIImage(data: data)
                ivDetailPoster?.image = image
            }
        }
            
        lblMovieOverview?.text = movieModel.overview
    }


}
