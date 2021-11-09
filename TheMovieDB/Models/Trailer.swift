//
//  Trailer.swift
//  TheMovieDB
//
//  Created by Juan Carlos Carbajal Ipenza on 09/11/21.
//

import Combine
import Foundation

/// Trailer
struct Trailer: Codable, Identifiable {
    var id: String
    var iso_639_1: String
    var iso_3166_1: String
    var name: String
    var key: String
    var site: String
    var size: Int
    var type: String
    var official: Bool
    var published_at: String
}
