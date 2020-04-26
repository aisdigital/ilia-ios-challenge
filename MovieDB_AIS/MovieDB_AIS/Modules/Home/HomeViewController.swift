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
    var searchController = UISearchController(searchResultsController: nil)
    var presenter: HomePresenter!
    var movies: [MovieObject] = []
    var moviesSearched: [MovieObject]?
    var currentPage = 1 {
        didSet {
            if moviesSearched != nil,
                let search = searchText{
                self.presenter.searchMovie(with: search)
                return
            }
            self.presenter.getMovies()
        }
    }
    var searchCurrentPage: Int = 0 {
        didSet {
            if let search = searchText {
                self.presenter.searchMovie(with: search)
                return
            }
        }
    }
    var searchText: String? {
        didSet {
            if searchText != nil {
                self.searchCurrentPage = 1
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
        definesPresentationContext = true
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
        self.setupSearchBar()
        self.title = HomeStrings.title.localized()
    }
    
    func setupCollection() {
        self.movieCollectionView.dataSource = self
        self.movieCollectionView.delegate = self
        MovieCell.registerNib(for: self.movieCollectionView)
    }
    
    func setupSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.tintColor = .white
        self.searchController.searchBar.searchTextField.textColor = .white

        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false


        searchController.searchBar.becomeFirstResponder()

        self.navigationItem.titleView = searchController.searchBar

    }
    
    func isSearchArrayEmpty() -> Bool {
        if let search = self.moviesSearched,
            search.isEmpty {
            return false
        }
        return true
    }
       
    func reloadCollection() {
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
    
    // MARK: - Actions

}

// MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func homePresenter(didSearchMoviesSuccessfully movies: [MovieObject]) {
        self.moviesSearched?.append(contentsOf: movies)
        reloadCollection()
    }
    
    func homePresenter(didGetMoviesSuccessfully movies: [MovieObject]) {
        self.movies.append(contentsOf: movies)
        reloadCollection()
    }
    
    func homePresenter(didFailToGetMovies failMessage: String) {
        self.showMessage(failMessage)
    }
    
}

// MARK: - COLLECTION VIEW DELEGATE
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let searched = moviesSearched {
            return searched.count
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MovieCell.dequeueCell(from: collectionView, for: indexPath)
        cell.movie = moviesSearched?[indexPath.row] ?? movies[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width*0.95, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let searched = self.moviesSearched,
            indexPath.row == searched.count - 1 {
            self.searchCurrentPage += 1
        } else if self.moviesSearched == nil,
            indexPath.row == self.movies.count - 1 {
            self.currentPage += 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigate(to: .description(movieSelected: moviesSearched?[indexPath.row] ?? movies[indexPath.row]))
    }
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.moviesSearched = self.movies.filter({
            return $0.title.contains(searchController.searchBar.searchTextField.text!)
        })
        if !isSearchArrayEmpty() {
            self.moviesSearched = nil
        }
        self.movieCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.moviesSearched = nil
        self.searchCurrentPage = 0
        self.searchText = nil
        reloadCollection()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if isSearchArrayEmpty(),
            let text = searchBar.searchTextField.text {
            self.searchText = text
        }
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
