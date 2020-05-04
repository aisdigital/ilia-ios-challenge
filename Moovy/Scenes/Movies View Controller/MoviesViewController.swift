//
//  MoviesViewController.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchTimer: Timer? = nil
    private var dataSource = DataSource() {
        didSet {
            bindDataSource()
            DispatchQueue.main.async {
                self.collectionView.delegate = self.dataSource
                self.collectionView.dataSource = self.dataSource
                self.collectionView.reloadData()
                self.refresh.endRefreshing()
            }
        }
    }
    
    lazy private var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    lazy private var refresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .baseOrange
        refresh.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        
        return refresh
    }()
    private let viewModel: MoviesViewModel
    
    // MARK: - Init
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        setupSearchController()
        bindViewModelStreams()
        
        viewModel.didBecomeActive()
    }
    
    // MARK: - Setups
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = StringConstants.movies
        
        let openSearchButton = UIBarButtonItem(image: UIImage(assetIdentifier: .searchIcon), style: .plain, target: self, action: #selector(openSearch))
        openSearchButton.tintColor = .baseOrange
        navigationItem.rightBarButtonItem = openSearchButton
    }
    
    private func setupCollectionView() {
        collectionView.register(MovieCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.allowsSelection = true
        collectionView.refreshControl = refresh
        createFlowLayout()
    }
    
    private func setupSearchController() {
        definesPresentationContext = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = StringConstants.movieSearchBarPlaceholder
        searchController.searchBar.backgroundColor = .baseDarkGray
        searchController.searchBar.tintColor = .baseOrange
        searchController.searchBar.barStyle = .black
        searchController.searchBar.keyboardAppearance = .dark
    }
    
    // MARK: - Bindings
    private func bindViewModelStreams() {
        viewModel.setDataSourceStream { [weak self] dataSource, hasPaged in
            guard hasPaged else {
                self?.dataSource = dataSource
                return
            }
            self?.dataSource.appendItems(dataSource.items)
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.setNoConnectionStream { [refresh] in
            DispatchQueue.main.async {
                AlertBuilder.shared.showSimpleAlertView(title: ErrorConstants.noConnectionTitle, message: ErrorConstants.noConnectionMessage)
                refresh.endRefreshing()
            }
        }
        
        viewModel.setFetchErrorStream { errorTitle, errorMessage in
            DispatchQueue.main.async {
                AlertBuilder.shared.showSimpleAlertView(title: errorTitle, message: errorMessage)
            }
        }
    }
    
    private func bindDataSource() {
        dataSource.setScrollViewDidScroll { [weak self, viewModel] scrollView in
            let distanceScrolled = (scrollView.frame.height + scrollView.contentOffset.y)
            let scrollContentSize = scrollView.contentSize.height
            
            
            self?.searchController.searchBar.endEditing(true)
            let flowLayout = self?.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            let itemSize = flowLayout?.itemSize
            
            if (distanceScrolled + ((itemSize?.height ?? 50) * 2)) >= scrollContentSize && !viewModel.isFetching {
                viewModel.fetchNextPage()
            }
        }
    }
    
    // MARK: - Private functions
    private func createFlowLayout() {
        let bounds = UIScreen.main.bounds
        let itemsPerRow: CGFloat = 2
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let spacing = (
            layout.sectionInset.left
                + layout.sectionInset.right
                + (layout.minimumInteritemSpacing * (itemsPerRow - 1))
        )
        let size = CGSize(width: (bounds.width - spacing) / itemsPerRow, height: (bounds.width / 3) * itemsPerRow)
        
        layout.itemSize = size
        
        collectionView.collectionViewLayout = layout
    }
    
    private func searchMovies() {
        if searchController.searchBar.isFirstResponder {
            viewModel.searchMovies(with: searchController.searchBar.text)
        }
    }
    
    private func clearSearch() {
        viewModel.clearSearch()
    }
    
    // MARK: - IBActions
    @IBAction private func refreshMovies() {
        guard Reachability.isConnectedToNetwork() else {
            DispatchQueue.main.async {
                AlertBuilder.shared.showSimpleAlertView(title: ErrorConstants.noConnectionTitle, message: ErrorConstants.noConnectionMessage)
                self.refresh.endRefreshing()
            }
            return
        }
        guard !searchController.isActive else {
            return
        }
        viewModel.refresh()
    }
    
    @IBAction private func openSearch(_ sender: UIBarButtonItem) {
        navigationItem.searchController = searchController
        present(searchController, animated: true, completion: nil)
    }
}

// MARK: - Extension: UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovies()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        clearSearch()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
        collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 0, height: 0), animated: true)
        refreshMovies()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchBar.text?.isEmpty == false else {
            clearSearch()
            return
        }
        searchMovies()
    }
}
