//
//  LoadingStatus.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import Foundation

enum LoadingState: Equatable {
    case idle
    case loading
    case failed(Error)
    case loaded
    
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case let (.failed(v0), .failed(v1)):
            let error1 = v0 as NSError
            let error2 = v1 as NSError
            return error1.code == error2.code
        default:
            return false
        }
    }
}
