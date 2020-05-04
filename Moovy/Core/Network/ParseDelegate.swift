//
//  ParseDelegate.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

protocol ParseDelegate {
    associatedtype ParseModel: Decodable
}

extension ParseDelegate {
    static func parseArray(data: Data) -> [ParseModel]? {
        do {
            let decoder = JSONDecoder()
            let items = try decoder.decode([ParseModel].self, from: data)
            return items
        } catch {
            return nil
        }
    }

    static func parseObject(data: Data) -> ParseModel? {
        do {
            let decoder = JSONDecoder()
            let item = try decoder.decode(ParseModel.self, from: data)
            return item
        } catch {
            return nil
        }
    }

    static func parseObject(data: Data?) -> ParseModel? {
        guard let data = data else {
            return nil
        }
        return parseObject(data: data)
    }
}

