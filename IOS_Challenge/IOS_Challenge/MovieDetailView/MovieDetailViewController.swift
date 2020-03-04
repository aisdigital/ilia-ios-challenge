//
//  MovieDetailViewController.swift
//  IOS_Challenge
//
//  Created by João Vitor Paiva on 04/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
class MovieDetailViewController: UIViewController {
    
  
    @IBOutlet weak var playerView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadYoutube(videoID: "2LqzF5WauAw")
    }
    
    
    func loadYoutube(videoID:String) {
        guard
            let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
            else { return }
        playerView.load( URLRequest(url: youtubeURL) )
        
    }

}
