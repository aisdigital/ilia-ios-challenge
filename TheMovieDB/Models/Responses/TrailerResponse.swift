//
//  TrailerResponse.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Foundation
import Combine

/// Response para um trailer
struct TrailerResponse: Codable {
    /// ID da resposta
    var id: Int
    /// Os trailers
    var results: [Trailer]
}
