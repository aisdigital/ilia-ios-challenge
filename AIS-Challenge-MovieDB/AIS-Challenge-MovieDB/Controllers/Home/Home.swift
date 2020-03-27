//
//  HomeViewController.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import UIKit
import SwiftMessages

protocol HomeDelegate: class {
    func setupNavbarTitleIcon()
    func setupActivityIndicator()
    func startLoading()
    func setupRefreshControl()
}

class Home: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var reloadData = false
    var refreshControl: UIRefreshControl!
    
    var presenter = HomePresenter(service: HomeServiceImplementation())
    
    var requestPage = 1;
    
    var movies: [Movie]?
    var moviesURLs: [String]?
    var selectedMovie: Movie?
    var selectedURL: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        showTheatreMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.setupUI()
        presenter.setView(delegate: self)
    }
    
    func showTheatreMovies () {
        startLoading()
        presenter.getTheatreMovies(page: requestPage) {
            (success, message, moviesData) in
            self.stopLoading()
            
            if success {
                self.movies = moviesData?.results
                self.movies = self.movies!.sorted(by: { $0.popularity! > $1.popularity! })
                self.moviesTableView.reloadData()
            }
        }
    }
    
    @objc func refreshMovies () {
        requestPage = 1
        reloadData = true
        presenter.getTheatreMovies(page: requestPage) {
            (success, message, moviesData) in
            
            if success {
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.moviesTableView.reloadData()
                    self.reloadData = false
                }
            }
        }
    }
        
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueStrings.movieToDetail {
            let destinationVC = segue.destination as! MovieDetails
            destinationVC.movie = selectedMovie!
            destinationVC.movieImageURL = selectedURL!
        }
    }

}
