//
//  APIEnvironment.swift
//  Moovy
//
//  Created by Pedro Arenhardt Wagner  on 01/05/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct APIEnvironment {
    static var shared = APIEnvironment()
    
    private let servicesDictionary: NSDictionary = {
        guard let plistPath = Bundle.main.path(forResource: "Services", ofType: "plist") else { fatalError("Couldn't find Servicez.plist") }
        guard let dictonary = NSDictionary(contentsOfFile: plistPath) else { fatalError("Couldn't read file Services.plist. Please check the plist format and integrity.") }
        return dictonary
    }()
    
    private var baseURL: String {
        get {
            guard let baseURL = servicesDictionary["baseURL"] as? String else { fatalError("Didn't find a value for key 'baseURL'")}
            return baseURL
        }
    }
    
    private var apiKey: String {
        get {
            guard let apiKey = servicesDictionary["apiKey"] as? String else { fatalError("Didn't find a value for key 'apiKey'")}
            return apiKey
        }
    }
    
    private var apiConfiguration: APIConfiguration? {
        guard let data = UserDefaults.standard.value(forKey: "APIConfiguration") as? Data else { return nil }
        return try? JSONDecoder().decode(APIConfiguration.self, from: data)
    }
    
    // MARK: - Setup
    func setupAPIConfiguration() {
        BaseAPIService.shared.get(url: getUrl(for: .apiConfiguration)) { data, error in
            guard error == nil else {
                return
            }
            guard let data = data,
                let config = APIConfiguration.parseObject(data: data) else {
                    AlertBuilder.shared.showSimpleAlertView(title: ErrorConstants.genericErrorTitle, message: ErrorConstants.genericParseErrorMessage)
                return
            }
            do {
                let data = try JSONEncoder().encode(config)
                UserDefaults.standard.set(data, forKey: "APIConfiguration")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Functions
    func getUrl(for endpoint: APIEnvironmentEndpoints, urlParameters: [URLParameters: String]? = nil, queryParameters: [EndpointParameters: String]? = nil) -> String {
        var url = addApiKeyAndLocationToURL(url: baseURL + endpoint.rawValue)
        
        if let urlParameters = urlParameters {
            url = replaceURLParameters(url: url, parameters: urlParameters)
        }
        
        guard let queryParameters = queryParameters else {
            return url
        }
        return replaceQueryParameters(url: url, queryParameters: queryParameters)
    }
    
    func getImageQueryURL(for path: String, size: ImageSize, imageType: ImageType) -> String? {
        guard let config = apiConfiguration else { return nil }
        return config.getImageQueryURL(for: path, size: size, imageType: imageType)
    }
    
    // MARK: - Privates
    private func addApiKeyAndLocationToURL(url: String) -> String {
        return String(format: "%@?%@=%@&%@=%@", url, EndpointParameters.api_key.rawValue, self.apiKey, "language", Locale.preferredLanguages.first ?? "")
    }
    
    private func replaceURLParameters(url: String, parameters: [URLParameters: String]) -> String {
        var urlCopy = url
        for (parameter, value) in parameters {
            urlCopy = urlCopy.replacingOccurrences(of: parameter.rawValue, with: value)
        }
        return urlCopy
    }
    
    private func replaceQueryParameters(url: String, queryParameters: [EndpointParameters: String]) -> String {
        var urlCopy = url
        
        for (parameter, value) in queryParameters {
            urlCopy += String(format: "&%@=%@", parameter.rawValue, value)
        }
        return urlCopy
    }
}

enum APIEnvironmentEndpoints: String {
    case apiConfiguration = "configuration"
    case movies = "movie/now_playing"
    case searchMovies = "search/movie"
    case movieVideos = "movie/{movie_id}/videos"
    case movieDetails = "movie/{movie_id}"
    case movieCastAndCrew = "movie/{movie_id}/credits"
}

enum URLParameters: String {
    case movieId = "{movie_id}"
}

enum EndpointParameters: String {
    case api_key
    case page
    case movieTitleQuery = "query"
}
