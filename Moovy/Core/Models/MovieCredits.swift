//
//  MovieCredits.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 04/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct MovieCredits: Decodable {
    let cast: [Person]
    let crew: [Person]
}

extension MovieCredits: ParseDelegate {
    typealias ParseModel = MovieCredits
}
