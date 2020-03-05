//
//  IOS_ChallengeTests.swift
//  IOS_ChallengeTests
//
//  Created by João Vitor Paiva on 03/03/20.
//  Copyright © 2020 joaovitorpaiva. All rights reserved.
//

import XCTest
@testable import IOS_Challenge

class IOS_ChallengeTests: XCTestCase {
    
    var networkManager : NetworkManager!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = NetworkManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchInTheatresMovies(){
        
        let networkManager = NetworkManager()
        networkManager.fetchInTheatresMovies(page: 1) { (result, error) in
            if error == nil{
                
                guard let movies = result?.movies else{
                    return
                }
                
                XCTAssertGreaterThan(movies.count, 0)
               
            }
        }
    }
    
    func testInTheatresViewModel(){
        
        let viewModel = InTheatresViewModel(networkManager: networkManager)
        
        XCTAssertEqual(viewModel.inTheatres.movies.count, 0)
        
        viewModel.fetchNowPlayingMovies { (success) in
            XCTAssertGreaterThan(viewModel.inTheatres.movies.count, 0)
        }
    }

    func testMovieDetailViewController(){
        
        let viewController = MovieDetailViewController()
        let viewModel = MovieDetailViewModel(networkManager: networkManager)
        
        viewModel.fetchMovie(movieID: 1) { (success) in
            XCTAssertEqual(viewController.titleLabel.text, viewModel.movie?.title)
            XCTAssertEqual(viewController.overviewTextView.text, viewModel.movie?.overview)
            XCTAssertEqual(viewController.voteAverageLabel.text, "Vote Average: \( String(describing: viewModel.movie!.voteAverage!))")
            XCTAssertEqual(viewController.popularityLabel.text, "Popularity: \(String(describing: viewModel.movie!.popularity!))")
        }
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
