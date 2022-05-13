//
//  Extension+String.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 10/04/22.
//

import Foundation

extension String {
    func toFormattedDate(dateFormat: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        return date
    }
}
