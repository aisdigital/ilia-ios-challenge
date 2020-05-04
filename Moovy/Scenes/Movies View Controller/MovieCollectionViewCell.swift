//
//  MovieCollectionViewCell.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 02/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = ""
    }
    
    static func newRow(with movie: Movie, delegate: MoviesCoordinatorDelegate?) -> Row {
        let row = Row(identifier: String(describing: MovieCollectionViewCell.self))
        
        row.setConfiguration { (cell, _, _) in
            guard let cell = cell as? MovieCollectionViewCell else { return }
            cell.cornerOn(.all, radius: 5)
            cell.imageView.downloadImage(for: movie.posterPath ?? "", withSize: .medium, imageType: .poster)
            cell.titleLabel.text = movie.title
        }
        
        row.setDidSelect { (_, _, _) in
            delegate?.openMovie(movie: movie)
        }
        
        return row
    }
}
