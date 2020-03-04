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
    var nowPlaying : NowPlaying = NowPlaying(movies: [], page: 0, totalPages: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let data = NetworkManager()
        
        data.fetchNowPlayingMovies { (nowPlaying, error) in
            
            self.nowPlaying = nowPlaying!
            self.tableView.reloadData()
            
            
        }
       
    }
}

extension NowPlayingViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlaying.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = self.nowPlaying.movies[indexPath.row].title
        return cell
    }
    
}
