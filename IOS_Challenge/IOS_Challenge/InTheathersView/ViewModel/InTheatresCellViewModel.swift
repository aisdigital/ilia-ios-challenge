//
//  NowPlayingCellViewModel.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import Foundation

protocol InTheatresCellViewModelProtocol: class {
    
    var imageData : Data? {get set}
    var didReceiveImageData: ((InTheatresCellViewModelProtocol)->())? {get set}
    
    init(networkManager : NetworkManager)
    func fetchImage(imagePath: String)
}


class NowPlayingCellViewModel: InTheatresCellViewModelProtocol {
    
    let networkManager: NetworkManager
    
    var imageData: Data?{
        didSet{
            didReceiveImageData?(self)
        }
    }
    
    var didReceiveImageData: ((InTheatresCellViewModelProtocol) -> ())?
    
    required init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchImage(imagePath: String) {
        networkManager.fetchMoviePoster(imagePath: imagePath) { (data, error) in
            self.imageData = data!
        }
    }
    
    
}
