//
//  FilmsTableViewController.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {
    
    private var filmsViewModel: FilmsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filmsViewModel = FilmsTableViewModel()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if filmsViewModel.films.count == 0{
            return 3
        }
        return filmsViewModel.films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmTableViewCell
        
        if filmsViewModel.films.count == 0{
            cell.filmNameLabel.text = "teste"
            
            return cell
        }
        cell.filmNameLabel.text = filmsViewModel.films[indexPath.row].name
        //cell.filmImageView.image = filmsViewModel.filmsImage[indexPath.row]
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filmsViewModel.films.count)
        //print(filmsViewModel.theMovieAPI.films.count)
        tableView.reloadData()
    }

}

extension FilmsTableViewController: ReloadViewDelegate{
    func reloadView() {
        tableView.reloadData()
    }
    
}
