//
//  URLAcess.swift
//  ilia-ios-challenge
//
//  Created by marcelo frost marchesan on 14/09/21.
//

import Foundation

struct URLAccess {
    
    private let url = "https://api.themoviedb.org/3/movie/"
    private let nowPlaying = "now_playing"
    private let key = "?api_key=9bb5dedd32e1506a310fd0bcb3409afa"
    
    func getURL () -> String{
        return url
    }
    
    func getNowPlaying () -> String {
        return nowPlaying
    }
    
    func getKey () -> String {
        return key
    }
}
