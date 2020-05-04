//
//  UIImageExtensions.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 02/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(assetIdentifier: UIImageAssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}

enum UIImageAssetIdentifier: String {
    case searchIcon
    case cancelIcon
}
