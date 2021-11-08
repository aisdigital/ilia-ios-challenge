//
//  TableViewCompatible.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 08/11/21.
//

import Foundation

protocol TableViewCompatible {
    
    var reuseIdentifier: String { get }
    
    var error: Observable<Bool> {  get set }
}
