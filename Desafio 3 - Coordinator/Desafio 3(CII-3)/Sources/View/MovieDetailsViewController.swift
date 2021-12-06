//
//  movieDetailsViewController.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var data: MovieResult?
    var controller = MovieOverviewViewModel()
    weak var coordinator: MainCoordinator?
    var newValue = PublishSubject<MovieResult>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newValue.subscribe { movie in
            self.data = movie
        }
        
        // Do any additional setup after loading the view.
        
        movieTitleLabel.text = data?.title

        movieDetailsLabel.text = data?.overview == "" ? "No overview avaliable" : data?.overview
        
        releaseDateLabel.text = "Release date: \(controller.formatDate(date: data?.releaseDate ?? ""))"
        
        guard let posterPath = data?.posterPath else {
            return
        }
        
        controller.loadImage(url: posterPath){
            (datas) in
                self.movieImageView.image = UIImage(data: datas ?? Data())
        }
        
        let voteString = "Vote average: \(data?.voteAverage ?? 0)"
        let attributedString = NSMutableAttributedString.init(string: voteString)
        let range = (voteString as NSString).range(of: String(data?.voteAverage ?? 0))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: controller.getTextColor(average: data?.voteAverage ?? 0), range: range)
        movieAverageLabel.attributedText = attributedString
        movieAverageLabel.isUserInteractionEnabled = false
    }
}
