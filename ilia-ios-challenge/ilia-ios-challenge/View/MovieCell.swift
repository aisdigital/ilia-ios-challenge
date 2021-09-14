//
//  MovieCell.swift
//  ilia-ios-challenge
//
//  Created by marcelo frost marchesan on 13/09/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var movieTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(movieTitleLabel)
        configureLabel()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureLabel(){
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setLabelConstraints() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}
