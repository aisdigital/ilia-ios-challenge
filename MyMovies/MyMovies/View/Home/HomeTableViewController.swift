//
//  HomeTableViewController.swift
//  MyMovies
//
//  Created by Wesley Brito on 03/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import UIKit
import Kingfisher
import FSPagerView

class HomeTableViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: HomeCoordinator?
    
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    private var homePresenter = HomePresenter()
    let searchController = UISearchController(searchResultsController: nil)
    
    var pageCount: Int = 1
    var movieTotalPages: Int = 0
    var searchTotalPages: Int = 0
    var query: String = ""
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter.delegate = self
        fsPagerView.delegate = self
        fsPagerView.dataSource = self
        fsPagerView.automaticSlidingInterval = 3
        searchControllerConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homePresenter.loadMovies(pageCount: pageCount)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let vc = segue.destination as? HomeDetailTableViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
                vc.movieId = homePresenter.getId(indexPath.row, isSearching)
            }
        }
    }
    
    func searchControllerConfiguration() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        // For change textColor of SearchBar
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        isSearching = false
        homePresenter.loadMovies()
    }
    
    
}

// MARK: - UISearchController
extension HomeTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.tableView.reloadData()
        self.fsPagerView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if homePresenter.searchTextIsValid(text: searchText) {
                homePresenter.cleanSearch()
                self.query = searchText
                homePresenter.searchMovies(query: searchText)
            } else {
                self.alertShow(title: "Error", message: "Large text", action: nil)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {}
}

// MARK: - HomePresenterDelegate
extension HomeTableViewController: HomePresenterDelegate {
    func movieFound(_ error: RequestErrors?) {
        if let error = error, error == .unexpectedError {
            return
        }
        isSearching = false
        self.movieTotalPages = homePresenter.getMovieTotalPages()
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
        self.fsPagerView.reloadData()
    }
    
    func searchFound(_ error: RequestErrors?) {
        if let error = error, error == .unexpectedError {
            return
        }
        isSearching = true
        self.searchTotalPages = homePresenter.getSearchTotalPages()
        self.tableView.reloadData()
        self.fsPagerView.reloadData()
    }
}

// MARK: - TableView
extension HomeTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? homePresenter.getSearchListCount() : homePresenter.getMovieListCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        if let cell = cell as? HomeTableViewCell {
            cell.posterImage.kf.indicatorType = .activity
            cell.posterImage.kf.setImage(with: homePresenter.getPosterUrl(indexPath.row, isSearching))
            cell.titleLabel.text = homePresenter.getTitle(indexPath.row, isSearching)
            cell.voteAverageLabel.text = "\(homePresenter.getVoteAverage(indexPath.row, isSearching))"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.goToHomeDetailTableViewController(movieId: homePresenter.getId(indexPath.row, isSearching), movieTitle: homePresenter.getTitle(indexPath.row, isSearching))
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch isSearching {
        case true:
            if indexPath.row == homePresenter.getSearchListCount() - 3 && pageCount <= searchTotalPages {
                pageCount += 1
                homePresenter.searchMovies(query: query, pageCount: pageCount)
            }
        case false:
            if indexPath.row == homePresenter.getMovieListCount() - 3 && pageCount <= movieTotalPages {
                pageCount += 1
                homePresenter.loadMovies(pageCount: pageCount)
            }
        }
    }
}

// MARK: - Banner
extension HomeTableViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return isSearching ? homePresenter.getSearchListCount() : homePresenter.getMovieListCount()
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: homePresenter.getBackdropPathUrl(index, isSearching))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        self.coordinator?.goToHomeDetailTableViewController(movieId: homePresenter.getId(index, isSearching), movieTitle: homePresenter.getTitle(index, isSearching))
    }
    
}
