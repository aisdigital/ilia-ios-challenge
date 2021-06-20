//
//  MovieDetailsController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 20/06/21.
//

import UIKit
import Kingfisher

private let cellId = "cellId"
private let headerMovieId = "headerMovieId"
private let infoMovieId = "infoMovieId"
private let similarMovieId = "similarMovieId"

//MARK: - UICollectionViewFlowLayout
class HeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else {return}
                let contentOffSetY = collectionView.contentOffset.y
                attribute.frame = CGRect(
                    x: 0,
                    y: contentOffSetY,
                    width: collectionView.bounds.width,
                    height: attribute.bounds.height - contentOffSetY)
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


class MovieDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //MARK: - Properties
    var movie_id: Int?
    var moviesDetails: MovieDetails?
    var similiarMovies: [SimilarMovies] = []
    var currentPage: Int = 1
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMovieDetails()
        fetchSimilarMovies()
        print("movie_id: \(movie_id?.description ?? "")")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - API
    func fetchMovieDetails() {
        TheMovieDBService.shared.fetchMovieDetails(movie_id: movie_id!) { (info) in
            if let info = info {
                self.moviesDetails = info
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
        //MARK: - API
        func fetchSimilarMovies() {
            TheMovieDBService.shared.fetchSimilarMovies(movie_id: movie_id!, page: currentPage) { (info) in
                    if let info = info {
                        self.similiarMovies.append(contentsOf: info.results!)
                        print("Inserted", self.similiarMovies.count)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
        }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .mobile2You
        title = "Details Movie"
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 134, right: 0)
        collectionView.backgroundColor = .black
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerMovieId)
        collectionView.register(InfoMovieCell.self, forCellWithReuseIdentifier: infoMovieId)
        collectionView.register(SimilarMoviesCell.self, forCellWithReuseIdentifier: similarMovieId)
        collectionView.reloadData()
    }
}

extension MovieDetailsController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerMovieId, for: indexPath) as! HeaderView
        
        
        if let urlPoster = URL(string: "\(moviesDetails?.getImageBackDropPath().description ?? "")") {
            header.imageMovie.kf.setImage(with: urlPoster)
        } else {
            header.imageMovie.image = UIImage(named: "spider")
        }
        
        header.delegate = self
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoMovieId, for: indexPath) as!
                InfoMovieCell
            
            cell.nameMovieLabel.text = "\(moviesDetails?.title?.description ?? "")"
            cell.popularityLabel.text = "Popularity: \(moviesDetails?.popularity.rounded().description ?? "0.0")"
            cell.likesLabel.text = "\(moviesDetails?.vote_count?.description ?? "") Likes"
    
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: similarMovieId, for: indexPath) as! SimilarMoviesCell
        cell.movie_id = movie_id
        cell.similarMovies = similiarMovies
        cell.loadSimilar()
        cell.changeText()
        
        
        return cell
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.width * 0.66
        
        if indexPath.item == 0 {
            let cell = InfoMovieCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.layoutIfNeeded()
            
            let estimativaTamanho = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimativaTamanho.height
        }
        
        if indexPath.item == 1 {
            let cell = SlidePhotoMoviesCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.layoutIfNeeded()
            
            let estimativaTamanho = cell.systemLayoutSizeFitting(CGSize(width: width, height: width ))
            height = estimativaTamanho.height
        }
        
        return .init(width: width , height: height)
    }
    
}

extension MovieDetailsController: HeaderViewDelegate {
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}


