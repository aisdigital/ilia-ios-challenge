//
//  MoviesViewController.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

class MoviesViewController: UIViewController, Storyboarded {
    
    var moviesViewModel = MoviesViewModel()
    weak var coordinator: MainCoordinator?
    var passData = PublishSubject<MovieResult>()

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var bag = DisposeBag()
    var movies: [MovieResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        moviesViewModel.fetchData()
        bindData()
    }
    
    func reloadData() {
        self.moviesCollectionView.reloadData()
    }
    
    func bindData() {
        moviesViewModel.movies.subscribe(onNext: { [weak self] movies in
            self?.movies.append(contentsOf: movies)
            self?.reloadData()
        }).disposed(by: bag)
        moviesViewModel.changePage.subscribe { _ in
            self.moviesViewModel.fetchData()
        }.disposed(by: bag)
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.onBind(data: movies[indexPath.item])
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //moviesViewModel.movieData.updateList = indexPath.item
        coordinator?.seeMovieDetails()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 5.0 {
            moviesViewModel.loadPages()
        }
        
        coordinator?.seeMovieDetails()
    }
}
