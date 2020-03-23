//
//  DetailsMovieViewModel.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsMovieViewModel {
    
    var detailsMovie = BehaviorRelay<DetailsMovie?>(value: nil)
    var disposeBag = DisposeBag()
    weak var coordinator: MainCoordinator?
    var idMovie: Int
    
    init(idMovie: Int) {
        self.idMovie = idMovie
        getDetailsMovie()
        showTrailer()
    }
    
    func getDetailsMovie() {
        checkInternet()
        API.getDetailsMovie(id: idMovie)
            .subscribe(onNext: { [unowned self] movie in
                self.detailsMovie.accept(movie)
            }, onError: { error in
                print(error)
                
            }).disposed(by: disposeBag)
    }
    
    func showTrailer() {
        coordinator?.gotToTrailerMovie(idMovie: idMovie)
    }
    
    private func checkInternet() {
        if !API.isConnectedToInternet() {
            let alert = Utils.alert(title: "Ops!", message: "Porfavor, verifique sua conexão com a internet.") { [unowned self] _ in
                self.getDetailsMovie()
            }
            coordinator?.showAlert(alert: alert)
            return
        }
    }
}
