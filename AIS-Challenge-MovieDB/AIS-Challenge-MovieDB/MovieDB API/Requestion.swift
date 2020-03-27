//
//  Authentication.swift
//  AIS-Challenge-MovieDB
//
//  Created by Douglas Tonetto Pfeifer on 27/03/20.
//  Copyright © 2020 Douglas Tonetto Pfeifer. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

typealias completionHandler = (Bool, String?, NowPlayingMovies?) -> Void

protocol Requester {    
    func createRequest(_ path: String, page: Int, completion: @escaping completionHandler)
    func createImageURL(path: String) -> String
}

class Requestion: Requester {
    
    private func createURL(path: String, page: Int) -> String {
        let bundlePath = Bundle.main.path(forResource: BundleStrings.config, ofType: BundleStrings.plist)
        let config = NSDictionary(contentsOfFile: bundlePath!)
        let baseURLString = config![BundleStrings.serverURL] as! String
        let apiKey = config![BundleStrings.movieDBAPIKey] as! String
        
        return "\(baseURLString)/\(path)/?api_key=\(apiKey)&language=pt-BR&page=\(page)"
    }
    
    func createImageURL(path: String) -> String {
        let bundlePath = Bundle.main.path(forResource: BundleStrings.config, ofType: BundleStrings.plist)
        let config = NSDictionary(contentsOfFile: bundlePath!)
        let baseURLString = config![BundleStrings.imageServerURL] as! String
        
        return "\(baseURLString)\(path)"
    }
    
    func createRequest(_ path: String, page: Int, completion: @escaping completionHandler) {
        let url = createURL(path: path, page: page)
        print(url)
        AF.request(url, method: .get)
        .responseJSON {
            (response) in
            if let json = response.value as? Dictionary<String,Any> {
                if let message = json[RequestStrings.statusMessage] as? String {
                    completion(false, String(message), nil)
                } else if let _ = json[RequestStrings.page] {
                    let jsonData = response.data
                    let decoder = JSONDecoder()
                    do {
                        let nowPlayingMovies = try decoder.decode(NowPlayingMovies.self, from: jsonData!)
                        completion(true, nil, nowPlayingMovies)
                    } catch {
                        print("JSON ERROR: ", error)
                        completion(false, ErrorStrings.error1, nil)
                    }
                } else {
                    completion(false, ErrorStrings.error2, nil)
                }
            } else {
                completion(false, ErrorStrings.error3, nil)
            }
        }
    }
}
