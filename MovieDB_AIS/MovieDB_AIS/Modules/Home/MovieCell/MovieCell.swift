//
//  MovieCell.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 25/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    var movie: MovieObject? {
        didSet {
            self.titleLabel.text = movie?.title
            if let text = movie?.overview,
                !text.isEmpty {
                self.descriptionTextView.text = text
            }
            if let url = movie?.posterPath {
                self.urlImage = URL(string: "http://image.tmdb.org/t/p/w300/"+url)
            }
        }
    }
    
    var urlImage: URL? {
        didSet {
            guard let url = self.urlImage,
                self.movie?.imageGetted == nil else {
                    self.posterImage.image = self.movie?.imageGetted
                    return
            }
            posterImage.kf.setImage(with: url)
            self.movie?.imageGetted = self.posterImage.image
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
}
