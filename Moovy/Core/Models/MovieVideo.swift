//
//  MovieVideo.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 03/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable {
    // MARK: - Properties
    let id: String
    let key: String
    let name: String
    let site: String
    
    // MARK: - Computed Properties
    var youtubeURL: String {
        guard site.lowercased() == "youtube" else {
            return "https://vimeo.com/\(key)"
        }
        return "https://www.youtube.com/watch?v=\(key)"
    }
    
    var youtubeThumbnailURL: String {
        return "https://img.youtube.com/vi/\(key)/0.jpg"
    }
}

extension MovieVideoResponse: ParseDelegate {
    typealias ParseModel = MovieVideoResponse
}
