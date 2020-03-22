//
//  MoviesTableViewController.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 21/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesTableViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = MoviesTableViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupLoadMovies()
        setupCellConfiguration()
    }
}

extension MoviesTableViewController {
    private func setupTitle() {
        title = "Movies List"
    }
    
    private func setupLoadMovies() {
        viewModel.loadMovies()
        loadMoreMovies()
    }
    
    private func setupCellConfiguration() {
        viewModel.moviesList
            .bind(to: tableView
            .rx
            .items(cellIdentifier: MovieTableViewCell.identifier,
                   cellType: MovieTableViewCell.self)) {
                    row, movie, cell in
                    cell.configureWithMovie(movie: movie)
        }.disposed(by: disposeBag)
    }
    
    func loadMoreMovies() {
        tableView.rx.willDisplayCell.map { $0.indexPath.item }.distinctUntilChanged().withLatestFrom(viewModel.moviesList) {
            (item, movies) -> Bool in
            return item == movies.count - 10
        }
        .filter { $0 }
        .subscribe(onNext: { [unowned self] _ in
            self.viewModel.loadMovies()
        }).disposed(by: disposeBag)
    }
}
