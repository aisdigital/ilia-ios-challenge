//
//  NowPlayingTableViewCell.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
