//
//  MoviesDetailViewModel.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

typealias DataSourceStream = (DataSource) -> Void

final class MovieDetailViewModel {
    var movie: Movie
    var dataSourceStream: DataSourceStream?
    
    private var movieVideos: [MovieVideo]?
    private var movieCredits: MovieCredits?
    
    private let coordinator: Coordinator
    private let movieService = MovieService()
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Init
    init(movie: Movie, coordinator: Coordinator) {
        self.movie = movie
        self.coordinator = coordinator
    }
    
    // MARK: - Public Functions
    func getInfos() {
        getMovieVideos()
        getMovieDetails()
        getMovieCastAndCrew()
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            self?.buildDataSource()
        }
    }
    
    func setDataSourceStream(_ stream: @escaping DataSourceStream) {
        self.dataSourceStream = stream
    }
    
    func findStatusBarHeight() -> CGFloat {
        guard let movieCoordinator = coordinator as? MoviesCoordinator else { return 0 }
        return movieCoordinator.statusBarHeight
    }
    
    func goBack() {
        coordinator.dismissViewController()
    }
    
    // MARK: - Private functions
    private func buildDataSource() {
        let overviewRow = MovieOverviewTableViewCell.newRow(with: movie.overview)
        let ratingsRow = MovieRatingTableViewCell.newRow(totalRatings: movie.totalVotes, averageRatings: movie.voteAverage)
        var items = [[overviewRow, ratingsRow]]
        
        if let movieVideos = self.movieVideos, movieVideos.count != 0 {
            let videosRow = VideosCollectionTableViewCell.newRow(with: movieVideos)
            items[0].append(videosRow)
        }
        if let cast = movieCredits?.cast {
            let castRow = CastAndCrewCollectionTableViewCell.newRow(title: StringConstants.cast, people: cast)
            items[0].append(castRow)
        }
        if let crew = movieCredits?.crew {
            var uniqueCrew = [Person]()
            crew.forEach { if !uniqueCrew.contains($0) { uniqueCrew.append( $0 ) } }
            let crewRow = CastAndCrewCollectionTableViewCell.newRow(title: StringConstants.crew, people: uniqueCrew)
            items[0].append(crewRow)
        }
        
        dataSourceStream?(DataSource(items: items))
    }
    
    private func getMovieVideos() {
        dispatchGroup.enter()
        movieService.getMovieVideos(with: movie.id) { [weak self, dispatchGroup] movieVideos, error in
            dispatchGroup.leave()
            guard error == nil else {
                return
            }
            guard let movieVideos = movieVideos else { return }
            self?.movieVideos = movieVideos
        }
    }
    
    private func getMovieDetails() {
        dispatchGroup.enter()
        movieService.getMovieDetails(with: movie.id) { [weak self, dispatchGroup] movie, error in
            dispatchGroup.leave()
            guard error == nil else {
                return
            }
            guard let movie = movie else {
                return
            }
            self?.movie = movie
        }
    }
    
    private func getMovieCastAndCrew() {
        dispatchGroup.enter()
        movieService.getMovieCastAndCrew(for: movie.id) { [weak self, dispatchGroup] movieCredits, error in
            dispatchGroup.leave()
            guard error == nil else {
                return
            }
            guard let movieCredits = movieCredits else {
                return
            }
            self?.movieCredits = movieCredits
        }
    }
}
