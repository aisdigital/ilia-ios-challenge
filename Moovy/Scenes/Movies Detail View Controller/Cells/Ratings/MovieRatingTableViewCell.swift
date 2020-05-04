//
//  MovieRatingTableViewCell.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class MovieRatingTableViewCell: UITableViewCell {
    @IBOutlet weak var totalRatingsLabel: UILabel!
    @IBOutlet weak var averageRatingsLabel: UILabel!
    
    static func newRow(totalRatings: Int, averageRatings: Double) -> Row {
        let row = Row(identifier: String(describing: MovieRatingTableViewCell.self))
        
        row.setConfiguration { (cell, _, _) in
            guard let cell = cell as? MovieRatingTableViewCell else { return }
            cell.totalRatingsLabel.text = String(totalRatings)
            cell.createAverageRatingsAttributedString(from: averageRatings)
        }
        
        return row
    }
    
    private func createAverageRatingsAttributedString(from rating: Double) {
        let ratingString = rating != 0 ? String(rating) : "-"
        let ratingAttributedString = NSMutableAttributedString(string: ratingString, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        let outOfString = NSAttributedString(string: "/10", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .regular)])
        ratingAttributedString.append(outOfString)
        
        averageRatingsLabel.attributedText = ratingAttributedString
    }
}
