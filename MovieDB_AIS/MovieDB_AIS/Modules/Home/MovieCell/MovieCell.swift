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
            self.setupInitialState()
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
            
            posterImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeHolder")) { (result) in
                switch result {
                case .success(let response):
                    self.posterImage.image = response.image
                case .failure(let error):
                    print(error.errorDescription)
                    self.posterImage.image = #imageLiteral(resourceName: "placeHolder")
                }
            }
            
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    
    func setupInitialState() {
        self.titleLabel.text = "-"
        self.descriptionTextView.text = "-"
        self.posterImage.image = nil
    }
}
