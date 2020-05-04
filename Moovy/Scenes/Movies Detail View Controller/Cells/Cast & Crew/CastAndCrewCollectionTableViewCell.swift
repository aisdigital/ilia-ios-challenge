//
//  CastAndCrewCollectionTableViewCell.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 04/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class CastAndCrewCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var dataSource = DataSource() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.delegate = self.dataSource
                self.collectionView.dataSource = self.dataSource
                self.collectionView.reloadData()
            }
        }
    }
    
    static func newRow(title: String, people: [Person]) -> Row {
        let row = Row(identifier: String(describing: CastAndCrewCollectionTableViewCell.self))
        
        row.setConfiguration { (cell, _, _) in
            guard let cell = cell as? CastAndCrewCollectionTableViewCell else { return }
            cell.titleLabel.text = title
            cell.collectionView.register(PersonCell.self)
            cell.createCollectionViewFlowLayout()
            
            cell.dataSource = DataSource(items: [people.compactMap { person -> Row in
                return PersonCell.newRow(with: person)
            }])
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
        let cellHeight = bounds.height
        let cellWidth = (cellHeight * 3) / 4
        
        let size = CGSize(width: cellWidth, height: cellHeight)
        layout.itemSize = size
        
        
        collectionView.collectionViewLayout =  layout
    }
}
