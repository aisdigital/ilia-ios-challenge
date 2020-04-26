//  
//  HomeViewController.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 24/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    enum HomeRouter {
        case description(movieSelected: MovieObject)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    // MARK: - Properties
    var presenter: HomePresenter!
    var movies: [MovieObject] = []
    var currentPage = 1 {
        didSet {
            self.presenter.getMovies()
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
        self.setupCollection()
        self.title = HomeStrings.title.localized()
    }
    
    func setupCollection() {
        self.movieCollectionView.dataSource = self
        self.movieCollectionView.delegate = self
        MovieCell.registerNib(for: self.movieCollectionView)
    }
        
    // MARK: - Actions

}

// MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func homePresenter(didGetMoviesSuccessfully movies: [MovieObject]) {
        self.movies.append(contentsOf: movies)
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width*0.95, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            self.currentPage += 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigate(to: .description(movieSelected: movies[indexPath.row]))
    }
}

// MARK: - ROUTER FUNCTIONS
extension HomeViewController {
    func navigate(to selected: HomeRouter) {
        switch selected {
        case .description(let movieSelected):
            let vc = MovieDescriptionViewController()
            vc.movie = movieSelected
            self.present(vc, animated: true, completion: nil)
        }
    }
}
