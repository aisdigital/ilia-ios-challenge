//
//  APIConfiguration.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct APIConfiguration: Codable {
    let baseUrl: String
    let secureBaseUrl: String
    let backdropSizes: [String]
    let logoSizes: [String]
    let posterSizes: [String]
    let profileSizes: [String]
    let stillSizes: [String]
    
    enum CodingKeys: String, CodingKey {
        case images
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .images)
        self.baseUrl = try container.decode(String.self, forKey: .baseUrl)
        self.secureBaseUrl = try container.decode(String.self, forKey: .secureBaseUrl)
        self.backdropSizes = try container.decode([String].self, forKey: .backdropSizes)
        self.logoSizes = try container.decode([String].self, forKey: .logoSizes)
        self.posterSizes = try container.decode([String].self, forKey: .posterSizes)
        self.profileSizes = try container.decode([String].self, forKey: .profileSizes)
        self.stillSizes = try container.decode([String].self, forKey: .stillSizes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var nestedContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .images)
        try nestedContainer.encode(baseUrl, forKey: .baseUrl)
        try nestedContainer.encode(secureBaseUrl, forKey: .secureBaseUrl)
        try nestedContainer.encode(backdropSizes, forKey: .backdropSizes)
        try nestedContainer.encode(logoSizes, forKey: .logoSizes)
        try nestedContainer.encode(posterSizes, forKey: .posterSizes)
        try nestedContainer.encode(profileSizes, forKey: .profileSizes)
        try nestedContainer.encode(stillSizes, forKey: .stillSizes)
    }
    
    // MARK: - Public Functions
    func getImageQueryURL(for path: String, size: ImageSize, imageType: ImageType) -> String {
        let pathQuery = imagePathQuery(path, for: size, imageType: imageType)
        return String(format: "%@%@", self.secureBaseUrl, pathQuery)

    }
    
    // MARK: - Private Functions
    private func imagePathQuery(_ path: String, for size: ImageSize, imageType: ImageType) -> String {
        let imageSizeArray: [String] = {
            switch imageType {
            case .backdropImage:
                return self.backdropSizes
            case .logo:
                return self.logoSizes
            case .poster:
                return self.posterSizes
            case .profileImage:
                return self.profileSizes
            case .still:
                return self.stillSizes
            }
        }()
        let index: Int = {
            switch size {
            case .small:
                return 0
            case .medium:
                return imageSizeArray.count / 2
            case .big:
                return imageSizeArray.count - 2
            case .original:
                return imageSizeArray.count - 1
            }
        }()
        return String(format: "%@/%@", imageSizeArray[index], path)
    }
}

// MARK: - Helper Enums
enum ImageSize {
    case small
    case medium
    case big
    case original
}

enum ImageType {
    case backdropImage
    case logo
    case poster
    case profileImage
    case still
}

extension APIConfiguration: ParseDelegate {
    typealias ParseModel = APIConfiguration
}
