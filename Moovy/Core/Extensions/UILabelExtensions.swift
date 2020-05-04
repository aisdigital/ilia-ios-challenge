//
//  UILabelExtensions.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 04/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var localizableString: String {
        get {
            return NSLocalizedString(self.localizableString, comment: "")
        }
        set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }
}
