//
//  ViewController.swift
//  ilia-ios-challenge
//
//  Created by marcelo frost marchesan on 13/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    var movies: MoviesData?
    private var selectedMovie: Result?
    private let url: String = "https://api.themoviedb.org/3/movie/"
    private let nowPlaying: String = "now_playing"
    private let key: String = "?api_key=9bb5dedd32e1506a310fd0bcb3409afa"
    private var label = UILabel()
    private let viewBG = UIView()
    
    override func viewDidLoad() {
        viewBG.frame = view.bounds
        viewBG.translatesAutoresizingMaskIntoConstraints = false
        title = "Movies"
        super.viewDidLoad()
        view.addSubview(viewBG)
        setLabel()
        configureTableView()
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        getMovies()
    }
    
    func setLabel(){
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: view.frame.minY, width: view.frame.width, height: (view.frame.height) * 0.2 )
        label.text = "Movies from the Movies DB API"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
    }
    
    func getMovies(){
        let request = APIRequest(url: url, list: nowPlaying, key: key)
        request.getMoviesList {[weak self](response) in
            self?.movies = response
            debugPrint(self?.movies?.results.count ?? "No Data retrieved")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedMovie = movies?.results[indexPath.row]
        let vc = SecondScreenViewController(movie: selectedMovie!)
        let viewNavigation = UINavigationController(rootViewController: vc)
        viewNavigation.modalPresentationStyle = .fullScreen
        present(viewNavigation, animated: true)
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
        viewBG.addSubview(tableView)
        setTableViewDelegates()
        setConstraints()
    }

    
    func setConstraints () {
        tableView.frame = viewBG.frame
        var constraints = [NSLayoutConstraint]()
        constraints.append(viewBG.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(viewBG.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(viewBG.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(viewBG.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80))
        NSLayoutConstraint.activate(constraints)
    }
    
    func setTableViewDelegates () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

