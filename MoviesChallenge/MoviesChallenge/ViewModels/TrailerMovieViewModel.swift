//
//  TrailerMovieViewModel.swift
//  MoviesChallenge
//
//  Created by Lucas Santana Brito on 22/03/20.
//  Copyright © 2020 lsb. All rights reserved.
//

import RxSwift
import RxCocoa

class TrailerMovieViewModel {
    
    var trailerMovie = BehaviorRelay<[TrailerMovie]>(value: [])
    let disposeBag = DisposeBag()
    weak var coordinator: MainCoordinator?
    var idMovie: Int
    
    init(idMovie: Int) {
        self.idMovie = idMovie
        downloadTrailer()
    }
    
    
    func downloadTrailer() {
        checkInternet()
        API.getTrailer(id: idMovie)
            .subscribe(onNext: { [unowned self] resultTrailer in
                self.trailerMovie.accept(resultTrailer.results)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func getUrlTrailer() -> Observable<URLRequest> {
        trailerMovie.asObservable()
            .filter { $0.count > 0 }
            .map { $0.first!.getUrlTrailer() }.asObservable()
            
    }
    
    func checkUrlTrailer() {
        trailerMovie.asObservable()
            .filter { $0.isEmpty }
            .subscribe(onNext: { [unowned self] trailer in
                print(trailer)
                let alert = Utils.alert(title: "Ops!", message: "Não encontramos o trailer desse filme :/") { _ in
                    self.coordinator?.back()
                }
                DispatchQueue.main.async {
                    self.coordinator?.showAlert(alert: alert)
                }
            }).disposed(by: disposeBag)
    }
    
    private func checkInternet() {
        if !API.isConnectedToInternet() {
            let alert = Utils.alert(title: "Ops!", message: "Porfavor verifique sua conexão com a internet!") { [unowned self] _ in
                self.downloadTrailer()
            }
            coordinator?.showAlert(alert: alert)
            return
        }
    }
}
