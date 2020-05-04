//
//  Person.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 04/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct Person: Decodable, Equatable {
    let id: Int
    let name: String
    let character: String?
    let job: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character, job
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        character = try container.decodeIfPresent(String.self, forKey: .character)
        job = try container.decodeIfPresent(String.self, forKey: .job)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
    }
    
    // MARK: - Equatable
    static func==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
