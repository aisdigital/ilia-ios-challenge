//
//  MoviesTableViewModel.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import RxCocoa
import RxSwift

class MoviesTableViewModel {
    
    var resultMovies = BehaviorRelay<ResultMovies?>(value: nil)
    var moviesList = BehaviorRelay<[Movie]>(value: [])
    var filterMoviesList = BehaviorRelay<[Movie]>(value: [])
    var currentPage = 1
    weak var coordinator: MainCoordinator?
    private var disposeBag = DisposeBag()
    
    func loadMovies() {
        checkInternet()
        API.getMovies(page: currentPage).filter { $0.totalPages >= self.currentPage }
            .subscribe(onNext: { [unowned self] result in
            self.currentPage += 1
            let newValue = self.moviesList.value + result.movies
            self.moviesList.accept(newValue)
            
        }, onError: { [unowned self] error in
            let msg = API.apiKey.isEmpty ? "Porfavor, adicione uma key da api The moviesDB." : "Ocorreu um error!"
            let alert = Utils.alert(title: "Ops!", message: msg, handler: nil)
            self.coordinator?.showAlert(alert: alert)
        }).disposed(by: disposeBag)
    }
    
    func showDetailsMovie(idMovie: Int) {
        coordinator?.goToDetailsMovie(idMovie: idMovie)
    }
    
    private func checkInternet() {
        if !API.isConnectedToInternet() {
            let alert = Utils.alert(title: "Ops!", message: "Porfavor verifique sua conexão com a internet!") { [unowned self] _ in
                self.loadMovies()
            }
            coordinator?.showAlert(alert: alert)
            return
        }
    }
}
