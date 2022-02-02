//
//  TopMovieViewController.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 27/01/22.
//

import UIKit
import Lottie

class TopMovieViewController: UIViewController, UISearchBarDelegate {

    
    private var viewModel: HomeViewModel = HomeViewModel()
    private var movie: [MovieModel] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    let animateView = AnimationView(name: "loading")

    @IBOutlet weak var collectionTopMovie: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        viewModel.getTopMovie { results in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.collectionTopMovie.reloadData()
            }
        }
        bindEvents()
        addLoading()
        setupCollection()
        self.configureSearch()
    }
    
    // MARK: - Methods
    
    func addLoading() {
        view.addSubview(animateView)
        animateView.loopMode = .loop
        let posX = (UIScreen.main.bounds.width - 240)/2
        let posY = (UIScreen.main.bounds.height - 240)/2
        animateView.frame = CGRect(x: posX, y: posY, width: 240, height: 240)

        animateView.alpha = 1
        animateView.play()
        animateView.animationSpeed = 0.8

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animateView.pause()
            self.animateView.removeFromSuperview()
            self.animateView.isHidden = true
        }
    }
    
    func configureSearch() {
        navigationItem.searchController = self.searchController
        self.searchController.searchBar.placeholder = "Buscar Filme"
        self.searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.buscaMovie(texto: searchText)
    }
    
    func setupCollection() {
        collectionTopMovie.dataSource = self
        collectionTopMovie.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2)-10, height: 260)
        collectionTopMovie.setCollectionViewLayout(layout, animated: true)
        collectionTopMovie.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.reuseIdentifier)
    }
    
    func bindEvents() {
        viewModel.updateLayout = { [weak self] in
//            self?.collectionTopMovie.reloadData()
        }
    }
}

extension TopMovieViewController {
    func buscaMovie (texto: String) {
        BuscaService.shared.buscaMovie(texto: texto)
    }
}
    

extension TopMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesQuantity()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.getMovieAt(indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseIdentifier, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell.init(frame: .zero)
        }
        cell.setupModel(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicou no ", indexPath.item)
        
        let item = viewModel.getMovieAt(indexPath.item)
        navigationController?.pushViewController(DetalhesViewController(movieSelected: item), animated: true)

    }
    

}
