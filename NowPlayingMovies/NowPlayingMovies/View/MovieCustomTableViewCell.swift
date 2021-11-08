//
//  MovieCustomCell.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 07/11/21.
//

import Foundation
import UIKit

class MovieCustomTableViewCell :UITableViewCell{
    static let identifier = "MovieCell"
    
    private let cellImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        label.text = "custom cell"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let averageLabel:UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.text = "4"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    var id: Int = 0
    //weak var delegate: UserTableViewCellDelegate?
    
    weak var movieViewModel: MovieViewModel! {
        didSet {
            self.id = movieViewModel.movieId
            self.cellLabel.text = movieViewModel.title
            self.averageLabel.text = String(movieViewModel.voteAverage)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellLabel)
        contentView.addSubview(averageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.frame = CGRect(x: 305, y: 55, width: 15, height: 15)
        averageLabel.frame = CGRect(x: 320, y: 55, width: 50, height: 30)
        cellLabel.frame = CGRect(x: 5 , y: 5, width: 300, height: 50)
        setConstraints()
    }
    func setConstraints(){
        cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        
        cellImageView.heightAnchor.constraint(equalToConstant:contentView.frame.height*0.05).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant:contentView.frame.width*0.05).isActive = true
        cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
      
        averageLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor,constant: -10).isActive = true
        averageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
