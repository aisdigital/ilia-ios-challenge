//
//  ViewController.swift
//  IliaCodeChallenge
//
//  Created by Stephanie Torisu on 25/01/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var service: Service = Service()
    @IBOutlet weak var movieTable: UITableView!
    
    var filmes : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        service.getPopularMovies()
        bindEvents()
        configNavigationController()
           
    }
    
    
    func setupTableView(){
        movieTable?.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        movieTable?.delegate = self
        movieTable?.dataSource = self
    }
    
    func configNavigationController(){
        self.title = "Filmes"
        navigationController?.navigationBar.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    func bindEvents(){
        service.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                self?.movieTable?.reloadData()
            }
            //print("TRATOU O MODEL")
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.getMoviesListSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = service.getMovieAt(indexPath.row)
        let cell = movieTable.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        cell.setUpModel(movie)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = service.getMovieAt(indexPath.row)
        let movieDetailViewController = MovieDetailViewController(selectedMovie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }

 

    }
    




