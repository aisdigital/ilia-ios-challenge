//
//  MoviesTableViewCell.swift
//  iliaChallenge
//
//  Created by Morgana Galamba on 30/10/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesTableViewCell"

    public let moviePhoto : UIImageView = {
        let photo = UIImageView()
        return photo
    }()
    
    public let movieName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .left
        return label
    }()
    
    public let releaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        //contentView.addSubview(moviePhoto)
        contentView.addSubview(movieName)
        contentView.addSubview(releaseDate)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //movieName.heightAnchor.constraint(equalToConstant: 88),
            movieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            movieName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            movieName.bottomAnchor.constraint(equalTo: releaseDate.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            //movieName.heightAnchor.constraint(equalToConstant: 88),
            releaseDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            releaseDate.topAnchor.constraint(equalTo: movieName.bottomAnchor,constant: 16),
            releaseDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8)
        ])
        
    }
    

}
