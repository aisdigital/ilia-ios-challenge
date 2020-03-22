//
//  MovieTableViewCell.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 21/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    
    static let identifier = "cell"
    
    func configureWithMovie(movie: Movie) {
        titleLabel.text = movie.title
        voteLabel.text = String(movie.vote) + "/10"
        dateLabel.text = movie.date
        setupMovieImage(movie: movie)
    }
    
    func setupMovieImage(movie: Movie) {
        movieImageView.kf.setImage(with: movie.imagePoster())
        
        movieImageView.layer.cornerRadius = 16
        movieImageView.clipsToBounds = true
        movieImageView.layer.shadowColor = UIColor.white.cgColor
        movieImageView.layer.shadowOpacity = 1
        movieImageView.layer.shadowOffset = CGSize.zero
    }
}
