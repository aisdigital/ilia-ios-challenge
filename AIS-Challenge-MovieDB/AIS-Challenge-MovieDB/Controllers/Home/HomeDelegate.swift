//
//  HomeDelegate.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension Home: HomeDelegate {
     func setupNavbarTitleIcon() {
         let logoImage = UIImage(named: "theMovieDBIcon")
         let logoImageView = UIImageView(image: logoImage)
         navigationItem.titleView = logoImageView
     }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
    }
    
    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (refreshMovies), for: UIControl.Event.valueChanged)
        moviesTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
}

extension Home: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.prefetchDataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            if movies.isEmpty {
                return 0
            } else {
                return movies.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        
        let imageURL = presenter.getMovieImageURL(path: movies![indexPath.row].backgroundPath!)
        
        if cell.movieImage.image == nil {
            cell.startLoading()
        }
        cell.movieImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png")) { (image, error, cache, url) in
            cell.stopLoading()
        }
        
        cell.movieTitle.text = movies![indexPath.row].title
        cell.movieDescription.text = movies![indexPath.row].overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedMovie = movies![indexPath.row]
        selectedURL = presenter.getMovieImageURL(path: movies![indexPath.row].backgroundPath!)
        performSegue(withIdentifier: "showMovieDetail", sender: indexPath)
    }
}

extension Home: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}
