//
//  Page.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct Page<T: Decodable> {
    let page: Int
    let totalPages: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        results = try container.decode([T].self, forKey: .results)
    }
}

extension Page: Decodable, ParseDelegate {
    typealias ParseModel = Page<T>
}
