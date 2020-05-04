//
//  BaseAPIService.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class BaseAPIService {
    static let shared = BaseAPIService()
    
    // MARK: - Get
    func get(url: String, completion: @escaping (Data?, String?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, ErrorConstants.genericErrorTitle)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, error?.localizedDescription)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
}
