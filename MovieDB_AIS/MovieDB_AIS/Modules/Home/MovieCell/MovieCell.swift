//
//  MovieCell.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 25/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    var movie: MovieObject? {
        didSet {
            self.titleLabel.text = movie?.title
            self.descriptionTextView.text = movie?.overview
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
}
