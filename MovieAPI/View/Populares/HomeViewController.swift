//
//  HomeViewController.swift
//  MovieAPI
//
//  Created by Marcylene Barreto on 24/01/22.
//

import UIKit
import Lottie

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    public var viewModel: HomeViewModel = HomeViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    let animateView = AnimationView(name: "loading")
    private var startingFrame: CGFloat = 0
    
    // MARK: - Outlet
    @IBOutlet weak var collectionPopulares: UICollectionView!
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        addLoading()
        viewModel.getPopularMovie { results in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.collectionPopulares.reloadData()
//                self.stopLoad()
            }
        }
        bindEvents()
        setupCollection()
        self.configureSearch()
    }
    
    // MARK: - Methods
    
    func addLoading() {
        view.addSubview(animateView)
        animateView.loopMode = .playOnce
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
        collectionPopulares.dataSource = self
        collectionPopulares.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2)-10, height: 260)
        collectionPopulares.setCollectionViewLayout(layout, animated: true)
        collectionPopulares.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.reuseIdentifier)
    }
    
    func bindEvents() {
        viewModel.updateLayout = { [weak self] in
//            DispatchQueue.main.async {
//                self?.collectionPopulares.reloadData()
//                self?.animateView.stop()
//            }
        }
    }
    
}

// MARK: - Extensions
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let texto = searchBar.text,
              !texto.trimmingCharacters(in: .whitespaces).isEmpty,
              texto.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? HomeViewController else {
                  return
              }
    }
    
    func buscaMovie (texto: String) {
        BuscaService.shared.buscaMovie(texto: texto)
        }
}
    

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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


