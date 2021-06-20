//
//  PopularController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit

private let reuseIdentifier = "PopularCell"

class PopularController: UICollectionViewController {
    //MARK: - Properties
    var movies: [Movie] = []
    var loadingMovies = false
    var currentPage: Int = 1
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPopular()
    }
    
    //MARK: - API
    func fetchPopular() {
        loadingMovies = true
        TheMovieDBService.shared.fetchPopular(page: currentPage) { (info) in
            if let info = info {
                self.movies.append(contentsOf: info.results!)
                print("Insertd", self.movies.count)
                DispatchQueue.main.async {
                    self.loadingMovies = false
                    self.collectionView.reloadData()
                }
            }
        }
    }
    //MARK: - Selectors
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        title = "Popular"
    }
}

//MARK: - UICollectionViewDelegate/DataSource
extension PopularController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopularCell
        
        print("poster: \(movies[indexPath.row].getImagePosterPath())")
        if let urlPoster = URL(string: "\(movies[indexPath.row].getImagePosterPath())") {
            cell.popularImageView.kf.setImage(with: URL(string: "\(urlPoster)"))
        } else {
            cell.popularImageView.image = UIImage(named: "notimagem")
        }
        cell.nameMovieLabel.text = "\(movies[indexPath.row].title?.description ?? "")"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 && !loadingMovies {
            currentPage += 1
            if movies.count > 0 {
                fetchPopular()
            }
            print("Loading more movies")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = MovieDetailsController()
        controller.movie_id = movies[indexPath.row].id
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}


