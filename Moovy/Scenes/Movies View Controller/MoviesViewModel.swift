//
//  MoviesViewModel.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 02/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

typealias PaginatedDataSourceStream = (_ dataSource: DataSource, _ hasPaged: Bool) -> Void
typealias NoConnectionStream = () -> Void
typealias FetchErrorStream = (_ title: String, _ message: String) -> Void

final class MoviesViewModel {
    var isFetching: Bool = false
    var coordinatorActions: MoviesCoordinatorDelegate?
    var hasPaged: Bool {
        if movieName != nil {
            return searchPage != 1
        }
        return page != 1
    }
    
    private var dataSourceStream: PaginatedDataSourceStream?
    private var noConnectionStream: NoConnectionStream?
    private var fetchErrorStream: FetchErrorStream?
    private var currentPageModel: Page<Movie>?
    private var page: Int = 1
    private var searchPage: Int = 1
    private var movieName: String?
    private var searchTimer: Timer?
    private let movieService = MovieService()
    
    // MARK: - Public Functions
    func didBecomeActive() {
        refresh()
    }
    
    func refresh() {
        self.page = 1
        self.searchPage = 1
        self.movieName = nil
        self.isFetching = true
        getMovies()
    }
    
    func fetchNextPage() {
        if checkIfTheresMorePages() {
            isFetching = true
            guard let movieName = self.movieName else {
                self.page += 1
                getMovies()
                return
            }
            self.searchPage += 1
            searchMovies(with: movieName)
        }
    }
    
    func searchMovies(with searchText: String?) {
        self.searchPage = 1
        searchTimer?.invalidate()
        guard let movieName = searchText else { return }
        guard !movieName.trimmingCharacters(in: .whitespaces).isEmpty else {
            dataSourceStream?(DataSource(), false)
            return
        }
        self.movieName = movieName
        searchTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(searchMoviesOnMDB),
            userInfo: nil,
            repeats: false
        )
    }
    
    func clearSearch() {
        searchTimer?.invalidate()
        self.searchPage = 1
        self.movieName = nil
        isFetching = true
        dataSourceStream?(DataSource(), false)
    }
    
    func setDataSourceStream(_ stream: @escaping PaginatedDataSourceStream) {
        self.dataSourceStream = stream
    }
    
    func setNoConnectionStream(_ stream: @escaping NoConnectionStream) {
        self.noConnectionStream = stream
    }
    
    func setFetchErrorStream(_ stream: @escaping FetchErrorStream) {
        self.fetchErrorStream = stream
    }
    
    // MARK: - Privates
    private func checkIfTheresMorePages() -> Bool {
            guard self.movieName != nil else {
            return self.page != self.currentPageModel?.totalPages
        }
        return self.searchPage != self.currentPageModel?.totalPages
    }
    
    private func getMovies() {
        guard Reachability.isConnectedToNetwork() else {
            noConnectionStream?()
            return
        }
        movieService.getMovies(page: self.page) { [weak self, dataSourceStream, coordinatorActions, fetchErrorStream, hasPaged] pageResponse, error in
            guard error == nil else {
                fetchErrorStream?(ErrorConstants.genericErrorTitle, ErrorConstants.genericFetchErrorMessage)
                return
            }
            guard let pageResponse = pageResponse else {
                fetchErrorStream?(ErrorConstants.genericErrorTitle, ErrorConstants.genericParseErrorMessage)
                return
            }
            
            self?.isFetching = false
            self?.currentPageModel = pageResponse
            let items = pageResponse.results.compactMap({ movie -> Row in
                return MovieCollectionViewCell.newRow(with: movie, delegate: coordinatorActions)
            })
            
            dataSourceStream?(DataSource(items: [items]), hasPaged)
        }
    }
    
    @IBAction private func searchMoviesOnMDB() {
        guard Reachability.isConnectedToNetwork() else {
            noConnectionStream?()
            return
        }
        guard let movieName = self.movieName else { return }
        movieService.searchMovies(with: movieName, page: self.searchPage) { [weak self, dataSourceStream, fetchErrorStream, coordinatorActions, hasPaged] pageResponse, error in
            guard error == nil else {
                fetchErrorStream?(ErrorConstants.genericErrorTitle, ErrorConstants.genericFetchErrorMessage)
                return
            }
            guard let pageResponse = pageResponse else {
                fetchErrorStream?(ErrorConstants.genericErrorTitle, ErrorConstants.genericParseErrorMessage)
                return
            }
            
            self?.isFetching = false
            self?.currentPageModel = pageResponse
            let items = pageResponse.results.compactMap({ movie -> Row in
                return MovieCollectionViewCell.newRow(with: movie, delegate: coordinatorActions)
            })
            
            dataSourceStream?(DataSource(items: [items]), hasPaged)
        }
    }
}
