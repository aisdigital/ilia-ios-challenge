//
//  DetailsMovieViewController.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsMovieViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabels: UILabel!
    @IBOutlet weak var desctiptionTextView: UITextView!
    @IBOutlet weak var watchTrailerButton: UIButton!
    
    var viewModel: DetailsMovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.detailsMovie.value?.title)
    }
    
    @IBAction func goWatchTrailer(_ sender: UIButton) {
    }
    
}
