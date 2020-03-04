//
//  ViewController.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: NowPlayingViewModelProtocol!{
        didSet{
            self.viewModel.didChangeNowPlaying = { _ in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        viewModel = NowPlayingViewModel(networkManager: NetworkManager())
        viewModel.fetchNowPlayingMovies()
        
    }
}

extension NowPlayingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nowPlaying.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "MovieCell"
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NowPlayingTableViewCell else{
            fatalError("Could not setup table view cell.")
        }
        
        cell.movieTitle.text = viewModel.nowPlaying.movies[indexPath.row].title
        cell.fetchImageData(imagePath: viewModel.nowPlaying.movies[indexPath.row].posterPath)
        return cell
    }
    
}
