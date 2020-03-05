//
//  NowPlayingTableViewCell.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import UIKit

class InTheatresTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    var viewModel: InTheatresCellViewModelProtocol!{
        didSet{
            self.viewModel.didReceiveImageData = { [unowned self] viewModel in
                guard let data = viewModel.imageData else{
                    return
                }
                self.moviePoster.image = UIImage(data: data)
                self.imageActivityIndicator.stopAnimating()
                self.imageActivityIndicator.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = NowPlayingCellViewModel(networkManager: NetworkManager())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fetchImageData(imagePath: String){
        self.imageActivityIndicator.startAnimating()
        self.viewModel.fetchImage(imagePath: imagePath)
    }

}
