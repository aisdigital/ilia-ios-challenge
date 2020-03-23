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
    var idMovie: Int
    
    init(idMovie: Int) {
        self.idMovie = idMovie
        downloadTrailer()
    }
    
    
    func downloadTrailer() {
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
}
