//
//  UIViewExtensions.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UIView {
    func cornerOn(_ corner: Corners, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corner.mask
    }
    
    func addBorder(width: CGFloat? = nil, color: UIColor? = nil) {
        layer.borderWidth = width ?? 0
        layer.borderColor = color?.cgColor
    }
    
    func roundedBorders() {
        cornerOn(.all, radius: frame.height / 2)
    }
    
    func addBasicShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        clipsToBounds = false
    }
    
    func setActivityIndicator(center: CGPoint? = nil, color: UIColor? = .baseOrange) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.tag = 1337
        activityIndicator.center = center ?? CGPoint(x: self.bounds.midX, y: self.bounds.midY)

        activityIndicator.color = color

        activityIndicator.startAnimating()
        addSubview(activityIndicator)
    }

    func removeActivityIndicator() {
        DispatchQueue.main.async {
            guard let view = self.viewWithTag(1337) else {
                return
            }
            
            view.removeFromSuperview()
        }
    }
}

//MARK:- Corner Struct
struct Corners: OptionSet {
    let rawValue: Int
    
    static let top = Corners(rawValue: 1)
    static let bottom = Corners(rawValue: 2)
    static let left = Corners(rawValue: 3)
    static let right = Corners(rawValue: 4)
    static let all = Corners(rawValue: 5)
    
    var mask: CACornerMask {
        var mask: CACornerMask = []
        
        if contains(.top) {
            mask.update(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        if contains(.bottom) {
            mask.update(with: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        if contains(.left) {
            mask.update(with: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        }
        
        if contains(.right) {
            mask.update(with: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        }
        
        if contains(.all) {
            mask.update(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        return mask
    }
}

