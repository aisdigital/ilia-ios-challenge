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

class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    private var homePresenter = HomePresenter()
    
    var pageCount: Int = 1
    var totalPages: Int = 0
    var isFiltering: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter.delegate = self
        fsPagerView.delegate = self
        fsPagerView.dataSource = self
        fsPagerView.automaticSlidingInterval = 3.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homePresenter.loadMovies(pageCount: pageCount)
    }
}

extension HomeTableViewController: HomePresenterDelegate {
    func movieFound(_ error: RequestErrors?, totalPages: Int) {
        self.totalPages = totalPages
        if let error = error, error == .noInternet {
            return
        }
        self.tableView.reloadData()
        self.fsPagerView.reloadData()
    }
}

// MARK: - TableView

extension HomeTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePresenter.getItensCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        if let cell = cell as? HomeTableViewCell {
            cell.posterImage.kf.indicatorType = .activity
            cell.posterImage.kf.setImage(with: homePresenter.getPosterUrl(indexPath.row))
            cell.titleLabel.text = homePresenter.getTitle(indexPath.row)
            cell.voteAverageLabel.text = "\(homePresenter.getVoteAverage(indexPath.row))"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homePresenter.getItensCount() - 3 && pageCount <= totalPages {
            pageCount += 1
            homePresenter.loadMovies(pageCount: pageCount)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Linha \(indexPath.row) selecionada...")
        //call detail
    }
}

// MARK: - Banner

extension HomeTableViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return homePresenter.getItensCount()
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: homePresenter.getBackdropPathUrl(index))
        
        return cell
    }
    
    
}
