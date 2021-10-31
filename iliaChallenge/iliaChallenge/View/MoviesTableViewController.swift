//
//  MoviesTableViewController.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 29/10/21.
//

import UIKit
import Alamofire
import WebKit

class MoviesTableViewController: UITableViewController {
    
    var viewModel = MoviesTableViewModel()
    var movies = Movie()
    override func viewDidLoad() {

        super.viewDidLoad()
        navigationItem.title = "Movies"
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        //viewModel.fetchMovies()
        fillMovies()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

   private func fillMovies() {
        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=f13794b05602015b7f895fed45d8e8f7&language=en-US&page=1").validate().responseJSON { response in
            guard response.error == nil else {
                let alert = UIAlertController(title: "Erro", message: "Algo errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
                return
            }
            
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode(Movie.self, from: data)
                    self.movies = models
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.results?.count ?? 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {
            return UITableViewCell()
        }

        cell.movieName.text = movies.results?[indexPath.row].title
        cell.releaseDate.text = "release on  \(movies.results?[indexPath.row].release_date) "
        
        return cell
    }

}
