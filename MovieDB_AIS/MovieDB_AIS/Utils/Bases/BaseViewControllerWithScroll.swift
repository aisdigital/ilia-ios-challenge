//
//  BaseViewControllerWithScroll.swift
// 
//
//  Created by Rhullian Damião on 21/11/19.
//  Copyright © 2019 MBLabs. All rights reserved.
//

import UIKit

protocol BaseViewControllerWithScrollMethods {
    func showLoader()
    func hideLoader()
    func showMessage(_ message: String)
}

class BaseViewControllerWithScroll: UIViewController, BaseViewControllerWithScrollMethods {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var greyView = UIView()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        setupScrollView()
    }
    
    @objc func showLoader() {
        
        guard let window = AppDelegate.window else { return }
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = window.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        let transfrom = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        activityIndicator.transform = transfrom
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        greyView.frame = CGRect(x: 0, y: 0, width: window.bounds.width, height: window.bounds.height)
        greyView.backgroundColor = UIColor.black
        greyView.alpha = 0.6
        self.view.addSubview(greyView)
    }
    
    @objc func hideLoader() {
        self.activityIndicator.stopAnimating()
        self.greyView.removeFromSuperview()
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: "Atenção!",
                                      message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: {_ in
            self.hideLoader()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupScrollView() {
        let boundsOfScreen = UIScreen.main.bounds
        self.contentView.frame.size = CGSize(width: boundsOfScreen.width,
                                             height: self.contentView.frame.size.height)
        self.scrollView.contentSize = self.contentView.frame.size
        self.scrollView.frame = boundsOfScreen
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.addSubview(self.contentView)
    }
}
