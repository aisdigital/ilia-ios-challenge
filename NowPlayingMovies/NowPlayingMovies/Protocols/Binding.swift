//
//  Binding.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 08/11/21.
//

import Foundation

protocol Binding {
    
    associatedtype T
    
    init(viewModel: T)
    
    func initBinding()    
}
