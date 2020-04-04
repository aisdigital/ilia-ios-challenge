//
//  HomeDetailTableViewController.swift
//  MyMovies
//
//  Created by Wesley Brito on 03/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import UIKit
import Kingfisher

class HomeDetailTableViewController: UITableViewController {
    
    var movieId: Int = 0
    
    private var homeDetailPresenter = HomeDetailPresenter()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeDetailPresenter.delegate = self
        trailerButton.layer.cornerRadius = 15
        trailerButton.layer.borderWidth = 2.0
        trailerButton.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeDetailPresenter.loadMovieDetailTrailer(movieId: movieId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let movieDetail = homeDetailPresenter.movieDetail {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w342\(movieDetail.posterPath)"))
            titleLabel.text = movieDetail.title
            averageLabel.text = "Votos: \(movieDetail.voteAverage)"
            descLabel.text = movieDetail.overview
            self.tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieTrailer" {
            if let vc = segue.destination as? MovieTrailerViewController {
                vc.youtubeKey = homeDetailPresenter.getMovieKey()
            }
        }
    }

}

extension HomeDetailTableViewController: HomeDetailPresenterDelegate {
    func movieTrailerFound(_ error: RequestErrors?) {
        if let error = error, error == .noInternet {
            return
        }
    }
    
    func movieDetailFound(_ error: RequestErrors?) {
        if let error = error, error == .noInternet {
            return
        }
    }
}
