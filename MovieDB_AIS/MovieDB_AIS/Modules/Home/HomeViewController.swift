//  
//  HomeViewController.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    enum HomeRouter {}
    
    // MARK: - Outlets
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    // MARK: - Properties
    var presenter: HomePresenter!
    var movies: [MovieObject] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }
    
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
        self.presenter = HomePresenter(delegate: self)
        MovieCell.registerNib(for: self.movieCollectionView)
        self.title = HomeStrings.title.localized()
    }
    
    // MARK: - Actions

}

// MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func homePresenter(didGetMoviesSuccessfully movies: [MovieObject]) {
        self.movies = movies
    }
    
    func homePresenter(didFailToGetMovies failMessage: String) {
        self.showMessage(failMessage)
    }
    
}

// MARK: - COLLECTION VIEW DELEGATE
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MovieCell.dequeueCell(from: collectionView, for: indexPath)
        cell.movie = movies[indexPath.row]
        return cell
    }
}

// MARK: - ROUTER FUNCTIONS
extension HomeViewController {
    func navigate(to selected: HomeRouter) {
    }
}
