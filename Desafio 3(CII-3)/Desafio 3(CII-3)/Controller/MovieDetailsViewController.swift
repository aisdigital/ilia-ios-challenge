//
//  movieDetailsViewController.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieAverageLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    var imageLink: String!
    var data = MoviesAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let path = data.storedMovies[data.newIndex]
        movieTitleLabel.text = path.title
        if path.overview == "" {
            movieDetailsLabel.text = "No overview avaliable"
        } else {
            movieDetailsLabel.text = path.overview
        }
        
        releaseDateLabel.text = "Release date: \(data.formatDate(date: path.releaseDate!))"
        
        guard let posterPath = path.posterPath else {
            return
        }
        data.loadImage(url: posterPath){
            (datas, error) in
            if error == nil{
                self.movieImageView.image = UIImage(data: datas!)
            }
        }
        let voteString = "Vote average: \(path.voteAverage ?? 0)"
        let attributedString = NSMutableAttributedString.init(string: voteString)
        let range = (voteString as NSString).range(of: String(path.voteAverage!))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: data.setTextColor(average: path.voteAverage!), range: range)
        movieAverageLabel.attributedText = attributedString
        movieAverageLabel.isUserInteractionEnabled = false
    }
}
