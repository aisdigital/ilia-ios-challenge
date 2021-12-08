//
//  Dates.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 29/11/21.
//

import Foundation

class Dates: Codable {
    let maximum, minimum: String?

    init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
}
