//
//  MovieCollectionViewCell.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 27/01/22.
//

import UIKit



class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func setUpModel(_ movie: Movie?) {
        guard let movieModel = movie else{return}
        lblMovieTitle?.text = movieModel.original_title
        
        guard let urlImage = movie?.poster_path else {return}
        if let url = URL(string: "https://image.tmdb.org/t/p/original/\(urlImage)"){
            if let data = try? Data(contentsOf: url){
                let image = UIImage(data: data)
                ivMovie?.image = image
            }
        }
    }

}

