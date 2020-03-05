//
//  DetailViewController.swift
//  iOS_Challenge
//
//  Created by Gabriel Messias on 04/03/20.
//  Copyright © 2020 Gabriel Messias. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var detailViewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.detailViewModel = (sender as! DetailViewModel)

    }
    
    func configInfo(){
        self.nameLabel.text = detailViewModel.name
        self.releaseYearLabel.text = detailViewModel.releaseYear
        self.overviewLabel.text = detailViewModel.overview
        self.imageView.image = detailViewModel.image
    }

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        self.detailViewModel = (sender as! DetailViewModel)
    }

}
