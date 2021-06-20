//
//  SlidePhotoMoviesController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "cellId"

class SlidePhotoMoviesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var movie_id: Int? = 0
    var similarMovies: [SimilarMovies] = []
    var currentPage: Int = 1
    var loadingMovies = false
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    func fetchSimilarMovies() {
        loadingMovies = true
        TheMovieDBService.shared.fetchSimilarMovies(movie_id: movie_id!, page: currentPage) { (info) in
            if let info = info {
                self.similarMovies.append(contentsOf: info.results!)
                print("Inserted", self.similarMovies.count)
                DispatchQueue.main.async {
                    self.loadingMovies = false
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        collectionView.register(SlidePhotoMoviesCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchSimilarMovies()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SlidePhotoMoviesCell
        cell.titleMovie.text = "\(similarMovies[indexPath.row].title ?? "")"
        cell.overviewMovie.text = "\(similarMovies[indexPath.row].overview ?? "")"
        
        if let urlPoster = URL(string: "\(similarMovies[indexPath.row].getImagePosterPath())") {
            cell.imageSimilarMovies.kf.setImage(with: URL(string: "\(urlPoster)"))
        } else {
            cell.imageSimilarMovies.image = UIImage(named: "notimage")
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == similarMovies.count - 1 && !loadingMovies {
            currentPage += 1
            
            if similarMovies.count > 0 {
                fetchSimilarMovies()
            }
            
            print("Loading more movies")
    }
}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 20, bottom: 5, right: 20)
    }
}

