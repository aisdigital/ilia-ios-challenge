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
        
        title = "Filmes"
        setupTableView()
        service.getPopularMovies()
        bindEvents()
        //filmes = ["homem aranha","eternos"]
           
    }
    
    
    func setupTableView(){
        movieTable.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        movieTable.delegate = self
        movieTable.dataSource = self
    }
    
    func bindEvents(){
        service.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                self?.movieTable.reloadData()
            }
            //print("TRATOU O MODEL")
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return filmes.count
        return service.getMoviesListSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = service.getMovieAt(indexPath.row)
        let cell = movieTable.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        cell.setUpModel(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    


 

    }
    




