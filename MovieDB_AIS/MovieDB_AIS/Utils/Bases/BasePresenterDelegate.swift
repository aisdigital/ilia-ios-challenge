//
//  BaseViewController.swift
//
//
//  Created by Rhullian Damião on 21/11/19.
//  Copyright © 2019 MBLabs. All rights reserved.
//

import UIKit

protocol BasePresenterDelegate: NSObjectProtocol {
    func showLoader()
    func hideLoader()
    func showMessage(_ message: String)
}
