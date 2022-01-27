//
//  MovieTableViewCell.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 25/01/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

       
       func setUpModel(_ movie: Movie?) {
           guard let movieModel = movie else{return}
           lblMovieTitle.text = movieModel.original_title
           
           guard let urlImage = movie?.poster_path else {return}
           if let url = URL(string: "https://image.tmdb.org/t/p/original/\(urlImage)"){
               if let data = try? Data(contentsOf: url){
                   let image = UIImage(data: data)
                   ivMovie.image = image
               }
           }
               
           lblDate.text = movieModel.release_date
       }
       
}
