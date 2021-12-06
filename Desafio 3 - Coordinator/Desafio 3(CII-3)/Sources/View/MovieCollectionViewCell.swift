//
//  MovieCollectionViewCell.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    let dataImage = MovieOverviewViewModel()

    func setup(with movie: String) {
        movieLabel.text = movie
        movieImageView.layer.cornerRadius = 8
    }
    
    func onBind(data: MovieResult) {
        movieLabel.text = data.title
        
        guard let imagePoster = data.posterPath else {
            return
        }
        dataImage.loadImage(url: dataImage.setImageLink(url: imagePoster)) { (data) in
            self.movieImageView.image = UIImage(data: data!)
        }
    }
}
