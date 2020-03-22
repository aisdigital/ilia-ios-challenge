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
    
    
}
