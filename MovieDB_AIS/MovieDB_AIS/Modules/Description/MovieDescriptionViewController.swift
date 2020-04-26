//  
//  MovieDescriptionViewController.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import UIKit

class MovieDescriptionViewController: BaseViewController {

    enum MovieDescriptionRouter {}
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var avaliationLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    // MARK: - Properties
    var presenter: MovieDescriptionPresenter!
    var movie: MovieObject!
    
    // MARK: - View Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConfig()
        presenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    // MARK: - Methods
    func setupConfig() {
        self.presenter = MovieDescriptionPresenter(delegate: self)
        self.setupLayout()
    }
    
    func setupLayout() {
        self.nameLabel.text = movie.title
        self.originalLabel.text = movie.originalTitle
        self.avaliationLabel.text = movie.voteAverage?.description
        self.descriptionView.text = movie.overview
        DispatchQueue.main.async {
            if let url = self.movie?.posterPath,
                let link = URL(string: "http://image.tmdb.org/t/p/w300/"+url) {
                self.posterImage.kf.setImage(with: link)
            }
            
        }
    }
    
    // MARK: - Actions

}

// MARK: - MovieDescriptionPresenterDelegate
extension MovieDescriptionViewController: MovieDescriptionPresenterDelegate {
}

// MARK: - ROUTER FUNCTIONS
extension MovieDescriptionViewController {
    func navigate(to selected: MovieDescriptionRouter) {
    }
}
