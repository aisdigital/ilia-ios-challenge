//
//  UICollectionViewExtensions.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(_ cell: AnyClass) {
        register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: cell.self))
    }
    
    func register(_ cells: AnyClass ...) {
        cells.forEach(register)
    }
    
    func disableUserInteraction() {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = false
        }
    }
    
    func enableUserInteraction() {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = true
        }
    }
}

