//
//  UIColorExtensions.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 02/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static var baseDarkGray: UIColor {
        return UIColor(hex: "20232A")
    }
    
    static var baseGray: UIColor {
        return UIColor(hex: "2B2F3A")
    }
    
    static var baseLightGray: UIColor {
        return UIColor(hex: "353B48")
    }
    
    static var baseDisabledGray: UIColor {
        return UIColor(hex: "7B8292")
    }
    
    static var baseRedishPink: UIColor {
        return UIColor(hex: "ED3269")
    }
    
    static var baseOrange: UIColor {
        return UIColor(hex: "F05F3E")
    }
}
