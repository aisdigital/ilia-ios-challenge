//
//  ViewController.swift
//  ilia-ios-challenge
//
//  Created by marcelo frost marchesan on 13/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var movies: MoviesData?
    
    private let url = "https://api.themoviedb.org/3/movie/"
    private let nowPlaying = "now_playing"
    private let key = "?api_key=9bb5dedd32e1506a310fd0bcb3409afa"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies List from The Movie DB API"
        configureTableView()
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        getMovies()
    }
    
    
    func getMovies(){
        let request = APIRequest(url: url, list: nowPlaying, key: key)
        request.getMoviesList {[weak self](response) in
            self?.movies = response
            debugPrint(self?.movies?.results.count ?? "No Data retrieved")
        }
        print("Results: \(String(describing: movies?.results.count))")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (movies?.results.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        cell.textLabel?.text = movies?.results[indexPath.row].title
        return cell
    }
    
    func configureTableView (){
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.addConstraints(view.constraints)
        tableView.frame = view.bounds
    }
    
    func setTableViewDelegates () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

