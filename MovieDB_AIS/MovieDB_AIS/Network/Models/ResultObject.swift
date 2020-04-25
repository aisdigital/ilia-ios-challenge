//
//  ResultObject.swift
//  MovieDB_AIS
//
//  Created by Rhullian Damião on 25/04/20.
//  Copyright © 2020 RDevign. All rights reserved.
//

import Foundation

class ResultObject<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}
