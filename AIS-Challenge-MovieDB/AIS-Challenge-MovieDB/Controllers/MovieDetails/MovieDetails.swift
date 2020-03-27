//
//  MovieDetailsViewController.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import UIKit

class MovieDetails: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    var movie: Movie?
    var movieImageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        movieImage.sd_setImage(with: URL(string: movieImageURL!), placeholderImage: UIImage(named: ImageStrings.placeholder))
        movieTitle.text = movie?.title
        movieDescription.text = movie?.overview
        movieGenre.text = "\(movie!.genreIds!)"
        moviePopularity.text = "\(movie!.popularity!)"
        movieScore.text = "\(movie!.voteAverage!)"
        movieDate.text = "\(movie!.releaseDate!)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
