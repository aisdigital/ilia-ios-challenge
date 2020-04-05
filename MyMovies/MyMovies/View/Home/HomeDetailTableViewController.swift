//
//  HomeDetailTableViewController.swift
//  MyMovies
//
//  Created by Wesley Brito on 03/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import UIKit
import Kingfisher

class HomeDetailTableViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: HomeDetailCoordinator?
    var movieId: Int = 0
    var movieTitle: String = ""
    
    private var homeDetailPresenter = HomeDetailPresenter()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movieTitle
        homeDetailPresenter.delegate = self
        trailerButton.layer.cornerRadius = 15
        trailerButton.layer.borderWidth = 2.0
        trailerButton.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingView.isHidden = false
        loadingView.startAnimating()
        self.view.isUserInteractionEnabled = false
        homeDetailPresenter.loadMovieDetailTrailer(movieId: movieId)
    }
    
    @IBAction func goToMovieTrailer(_ sender: UIButton) {
        coordinator?.goToMovieTrailerViewController(youtubeKey: homeDetailPresenter.getMovieKey())
    }
}

extension HomeDetailTableViewController: HomeDetailPresenterDelegate {
    func requestComplete(_ movieError: RequestErrors?, _ trailerError: RequestErrors?) {
        loadingView.isHidden = true
        loadingView.stopAnimating()
        self.view.isUserInteractionEnabled = true
        if let movieError = movieError,
        movieError == .unexpectedError,
        let trailerError = trailerError,
        trailerError == .unexpectedError {
            return
        }
        if let movieDetail = homeDetailPresenter.movieDetail {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w342\(movieDetail.posterPath)"))
            titleLabel.text = movieDetail.title
            averageLabel.text = "Votos: \(movieDetail.voteAverage)"
            descLabel.text = movieDetail.overview
            self.tableView.reloadData()
        }
    }
}
