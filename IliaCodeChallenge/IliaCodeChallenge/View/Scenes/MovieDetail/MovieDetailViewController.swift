//
//  MovieDetailViewController.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 27/01/22.
//

import UIKit

class MovieDetailViewController: ViewController {

    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblMovieVote: UILabel!
    
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
        configView()
        
        
    }

    func configView(){
        title = "Movie Details"
        lblMovieTitle.text = movieDet.original_title
                
                guard let urlImage = movieDet.poster_path else {return}
                if let url = URL(string: "https://image.tmdb.org/t/p/original/\(urlImage)"){
                    if let data = try? Data(contentsOf: url){
                        let image = UIImage(data: data)
                        ivMoviePoster?.image = image
                    }
                }
                    
                lblMovieOverview?.text = movieDet.overview
                lblMovieReleaseDate?.text = movieDet.release_date
                lblMovieVote?.text = String(movieDet.vote_average)
            }
    


}
