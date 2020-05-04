//
//  VideosCollectionTableViewCell.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class VideosCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource = DataSource() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.delegate = self.dataSource
                self.collectionView.dataSource = self.dataSource
                self.collectionView.reloadData()
            }
        }
    }
    
    static func newRow(with videos: [MovieVideo]) -> Row {
        let row = Row(identifier: String(describing: VideosCollectionTableViewCell.self))
        
        row.setConfiguration { (cell, _, _) in
            guard let cell = cell as? VideosCollectionTableViewCell else { return }
            let dataSource = DataSource(items: [videos.compactMap { video -> Row in
                return VideoCollectionViewCell.newRow(movieVideo: video)
            }])
            
            cell.collectionView.register(VideoCollectionViewCell.self)
            cell.createCollectionViewFlowLayout()
            
            cell.dataSource = dataSource
        }
        
        return row
    }
    
    private func createCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        let bounds = collectionView.bounds
        let cellHeight = bounds.height - 10
        let cellWidth = (cellHeight * 16) / 9
        
        let size = CGSize(width: cellWidth, height: cellHeight)
        layout.itemSize = size
        
        
        collectionView.collectionViewLayout =  layout
    }
}
