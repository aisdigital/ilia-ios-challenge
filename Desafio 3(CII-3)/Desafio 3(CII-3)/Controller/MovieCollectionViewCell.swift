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
    let dataImage = MoviesAPI()

    func setup(with movie: String) {
        movieLabel.text = movie
    }
    
    func onBind(data: Result) {
        movieLabel.text = data.title
        
        guard let imagePoster = data.posterPath else {
            return
        }
        dataImage.loadImage(url: dataImage.setImageLink(url: imagePoster)) { (data, error) in
            if error == nil {
                self.movieImageView.image = UIImage(data: data!)
            }
        }
    }
}
