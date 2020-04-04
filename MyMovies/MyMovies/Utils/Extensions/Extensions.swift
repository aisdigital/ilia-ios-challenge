//
//  Extensions.swift
//  MyMovies
//
//  Created by Wesley Brito on 02/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import Foundation
import UIKit

// MARK: Alert + Loading
extension UIViewController {
    func alertShow(title: String, message: String, action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: action))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadingView(isEnabled: Bool, message: String? = "Loading...") {
        self.view.isUserInteractionEnabled = isEnabled
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        if isEnabled {
            loadingIndicator.stopAnimating()
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: nil, message: message!, preferredStyle: .alert)
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            alert.view.accessibilityIdentifier = "Alert"
            present(alert, animated: true, completion: nil)
        }
    }
}
