//
//  MovieDetailsView.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 08/11/21.
//

import Foundation
import UIKit

class MovieDetailsView : UIView{
     let moviePosterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let titleLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        label.text = "Movie title"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
     let releaseDateDescriptionLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        label.text = "Movie Release Date"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
     let releaseDateLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.text = "movieRelease"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
     let voteAverageLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        label.text = "4"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
     let isAdultImage:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "classificacaoIndicativa")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let starImage:UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(named: "star.fill")
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    public init(){
        super.init(frame: .zero)
        self.addSubview(moviePosterImageView)
        self.addSubview(titleLabel)
        self.addSubview(releaseDateDescriptionLabel)
        self.addSubview(releaseDateLabel)
        self.addSubview(voteAverageLabel)
        self.addSubview(isAdultImage)
        self.addSubview(starImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: 5, y: 50, width: 300, height: 50)
        releaseDateDescriptionLabel.frame = CGRect(x: 5, y: 100, width: 200, height: 50)
        releaseDateLabel.frame = CGRect(x: 205, y: 100, width: 100, height: 50)
        voteAverageLabel.frame = CGRect(x: 5, y: 180, width: 100, height: 30)
        starImage.frame = CGRect(x: 105, y: 210, width: 50, height: 50)
        isAdultImage.frame = CGRect(x: 5, y: 260, width: 50, height: 50)

    }
}
