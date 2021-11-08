//
//  ViewController.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 06/11/21.
//

import UIKit

class MovieListViewController: UITableViewController, Binding {
    var movieListVM: MovieListViewModel!
    weak var coordinator: AppCoordinator?

    var safeArea: UILayoutGuide!
    
    required init(viewModel: MovieListViewModel) {
        super.init(style: .plain)
        self.movieListVM = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Now playing movies"
        self.setCellStyle()
        self.initBinding()
    }
    func initBinding() {
        movieListVM.movieViewModels.addObserver(fireNow: false) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    override func loadView() {
        super.loadView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func setCellStyle() {
        self.tableView.estimatedRowHeight = 233
        tableView.register(MovieCustomTableViewCell.self, forCellReuseIdentifier: movieListVM.reuseIdentifier)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieListVM.movieViewModels.value.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: movieListVM.reuseIdentifier, for: indexPath) as? MovieCustomTableViewCell else {
            return UITableViewCell()
        }
        let movieViewModel = self.movieListVM.movieViewModels.value[indexPath.row]
        cell.movieViewModel = movieViewModel
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieListVM.movieViewModels.value[indexPath.row]
      //  let movieTitle = movieListVM.movieViewModels.value[indexPath.row].title
        let vc = MovieDetailsViewController(movie: movie)
            let viewNavigation = UINavigationController(rootViewController: vc)
            present(viewNavigation, animated: true)
       // self.didTapCell(with: movieId)
    }
}
extension MovieListViewController: NavigableRow {
    func didTapCell(with movieId: Int) {
        //self.coordinator?.showDetails(with: movieId)
    }
    
}
