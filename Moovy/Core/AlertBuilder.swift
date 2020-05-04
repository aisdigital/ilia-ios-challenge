//
//  AlertBuilder.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class AlertBuilder {
    static let shared = AlertBuilder()
    
    private var activeViewController: UIViewController? = {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
    }()
    
    func showSimpleAlertView(title: String, message: String? = nil, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        if let activeViewController = activeViewController {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: actionHandler)
            
            alertView.addAction(okAction)
            
            activeViewController.present(alertView, animated: true)
        }
    }
}
