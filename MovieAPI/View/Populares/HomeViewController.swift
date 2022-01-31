//
//  HomeViewController.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 24/01/22.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var collectionPopulares: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .orange
        viewModel.getPopularMovie()
        bindEvents()
        setupCollection()
        self.configureSearch()
        
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
        collectionPopulares.dataSource = self
        collectionPopulares.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2)-10, height: 260)
        collectionPopulares.setCollectionViewLayout(layout, animated: true)
        collectionPopulares.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.reuseIdentifier)
    }
    
//    private func getPopularMovie() {
//        ApiMovie.shared.getPopularMovie { results in
//            switch results {
//            case .success(let movies):
//                print(movies)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func bindEvents() {
        viewModel.updateLayout = { [weak self] in
//            DispatchQueue.main.async {
//                self?.collectionPopulares.reloadData()
//            }
            self?.collectionPopulares.reloadData()
        }
    }
    
}

extension HomeViewController {
    func buscaMovie (texto: String) {
        BuscaService.shared.buscaMovie(texto: texto)
    }
}
    

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let item = viewModel.getMovieAt(indexPath.item)
        navigationController?.pushViewController(DetalhesViewController(movieSelected: item), animated: true)
    }
}


