//
//  MovieOverviewTableViewCell.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class MovieOverviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    static func newRow(with overview: String) -> Row {
        let row = Row(identifier: String(describing: MovieOverviewTableViewCell.self))
        
        row.setConfiguration { (cell, _, _) in
            guard let cell = cell as? MovieOverviewTableViewCell else { return }
            cell.overviewLabel.text = overview
        }
        
        return row
    }
}
