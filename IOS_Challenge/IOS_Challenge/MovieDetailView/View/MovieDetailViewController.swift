//
//  MovieDetailViewController.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class MovieDetailViewController: UIViewController {
    
  //Outlets
    @IBOutlet weak var playerView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    //Local variables
    var movieID: Int?
    var viewModel: MovieDetailViewModel!{
        didSet{
            self.viewModel.didChangeMovie = { [unowned self] viewModel in
                
                self.setupLabels(viewModel: viewModel)
                self.hideViews(isHidden: false)
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                if viewModel.movie!.videos?.results!.count != 0{
                    self.loadYoutube(videoID: (viewModel.movie!.videos?.results![0].key)!)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailViewModel(networkManager: NetworkManager())
        viewModel.fetchMovie(movieID: movieID!) { (success) in }
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        hideViews(isHidden: true)
    }
    
    private func hideViews(isHidden : Bool){
        playerView.isHidden = isHidden
        titleLabel.isHidden = isHidden
        overviewTextView.isHidden = isHidden
        genreLabel.isHidden = isHidden
        voteAverageLabel.isHidden = isHidden
        adultLabel.isHidden = isHidden
        popularityLabel.isHidden = isHidden
    }
    
    private func loadYoutube(videoID:String) {
        guard
            let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
            else { return }
        playerView.load( URLRequest(url: youtubeURL) )
        
    }

    private func setupLabels(viewModel: MovieDetailViewModelProtocol){
        
        self.titleLabel.text = viewModel.movie?.title
        self.overviewTextView.text = viewModel.movie?.overview
        
        var genreString = ""
        for n in 0..<viewModel.movie!.genres!.count{
            genreString += "\(String(describing: viewModel.movie!.genres![n].name!)), "
        }
        if viewModel.movie!.adult!{
            self.adultLabel.text = "Adult: Yes."
        }else{
            self.adultLabel.text = "Adult: No."
        }
        self.genreLabel.text = "Genres: \(genreString)"
        self.voteAverageLabel.text = "Vote Average: \( String(describing: viewModel.movie!.voteAverage!))"
        self.popularityLabel.text = "Popularity: \(String(describing: viewModel.movie!.popularity!))"
    }
}
