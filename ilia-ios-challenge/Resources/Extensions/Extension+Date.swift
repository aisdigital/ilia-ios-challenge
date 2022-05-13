//
//  Extension+Date.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import Foundation

extension Date {
   func toFormattedString(format: String = "dd/MM/yyyy") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
