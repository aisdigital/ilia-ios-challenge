//
//  VideoCollectionViewCell.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    static func newRow(movieVideo: MovieVideo) -> Row {
        let row = Row(identifier: String(describing: VideoCollectionViewCell.self))
        
        row.setConfiguration { (cell, _, _) in
            guard let cell = cell as? VideoCollectionViewCell else { return }
            
            cell.imageView.downloadImage(for: movieVideo.youtubeThumbnailURL)
            cell.imageView.cornerOn(.all, radius: 5)
        }
        
        row.setDidSelect { (_, _, _) in
            guard let url = URL(string: movieVideo.youtubeURL) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        return row
    }
}
