//
//  DetalhesViewController.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 28/01/22.
//

import UIKit
import WebKit

class DetalhesViewController: UIViewController {
    
    var details: MoviesItens
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var overviewMovie: UILabel!
    @IBOutlet weak var voteRate: UILabel!
    
    init(movieSelected: MoviesItens) {
        
        details = movieSelected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetails()
    }
    
    func setupDetails() {
//        title = "Detalhes"
        titleMovie.text = details.title
        overviewMovie.text = details.overview
        voteRate.text = details.vote_average
        
        guard let urlImage = details.poster_path else {return}
        if let url = URL(string: "https://image.tmdb.org/t/p/original\(urlImage)") {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                posterImage.image = image
            }
        }
    }

}
