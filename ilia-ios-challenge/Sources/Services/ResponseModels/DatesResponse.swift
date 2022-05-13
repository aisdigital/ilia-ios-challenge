//
//  DatesResponse.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation

class DatesResponse: Codable {
    let maximum, minimum: String?

    init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
}
