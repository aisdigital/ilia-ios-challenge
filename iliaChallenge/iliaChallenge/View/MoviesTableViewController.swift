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
                    //print(data)
                    print(models)
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
        //print(viewModel.movies.results)
        
       cell.movieName.text = movies.results?[indexPath.row].title
        cell.releaseDate.text = "release on  \(movies.results?[indexPath.row].release_date) "
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
