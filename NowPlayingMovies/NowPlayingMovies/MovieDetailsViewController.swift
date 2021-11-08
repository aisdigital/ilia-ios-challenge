//
//  MovieDetailsViewController.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 08/11/21.
//

import Foundation
import UIKit

class MovieDetailsViewController :UIViewController {
    var movieId = Int()
    var viewModel: MovieDetailsViewModel!
    var releaseDate = String()
    var voteAverage = Double()
    var isAdult = Bool()
    var movieDetaisView = MovieDetailsView()
    var movie:MovieViewModel
    weak var coordinator: AppCoordinator?
    
    init(movie:MovieViewModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = movieDetaisView
        self.movieDetaisView.titleLabel.text = movie.title
        self.movieDetaisView.releaseDateLabel.text = movie.releaseDate
        self.movieDetaisView.voteAverageLabel.text = String(movie.voteAverage)
        self.movieDetaisView.isAdultImage.image = UIImage(named: movie.adult ? "classificacaoIndicativa" : "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "details"
        self.view.backgroundColor = .white
    }
}
