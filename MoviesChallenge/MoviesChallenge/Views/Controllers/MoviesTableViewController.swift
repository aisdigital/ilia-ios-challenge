//
//  MoviesTableViewController.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 21/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit

class MoviesTableViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
    }
    
    private func setupTitle() {
        title = "Movies List"
    }
}
