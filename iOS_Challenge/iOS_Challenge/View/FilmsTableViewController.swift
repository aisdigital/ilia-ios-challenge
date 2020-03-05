//
//  FilmsTableViewController.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {
    
    private var filmsViewModel: FilmsTableViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filmsViewModel = FilmsTableViewModel()
        self.filmsViewModel?.viewDelegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (filmsViewModel?.films.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmTableViewCell
        
        if (filmsViewModel?.films.count)! > indexPath.row{
            cell.filmNameLabel.text = filmsViewModel!.films[indexPath.row].name
        }
        
        if (filmsViewModel?.filmsImage.count)! > indexPath.row{
            cell.filmImageView.image = filmsViewModel!.filmsImage[indexPath.row]
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailViewController = segue.destination as? DetailViewController, let index = tableView.indexPathForSelectedRow?.row else {return}
        
        let detailViewModel = DetailViewModel(film: (filmsViewModel?.films[index])!, image: (filmsViewModel?.filmsImage[index])!)
        
        detailViewController.detailViewModel = detailViewModel
    }
}

extension FilmsTableViewController: ReloadViewDelegate{
    func reloadView() {
        tableView.reloadData()
    }
    
}
