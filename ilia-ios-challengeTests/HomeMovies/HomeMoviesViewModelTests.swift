//
//  HomeMoviesViewModelTests.swift
//  ilia-ios-challengeTests
//
//  Created by Joao Paulo on 10/04/22.
//

import XCTest
@testable import ilia_ios_challenge

class HomeMoviesViewModelTests: XCTestCase {
    
    var homeMoviesViewModel: HomeMoviesViewModel!
    var moviesRepository: MoviesRepositoryMock!
    
    
    override func setUpWithError() throws {
        moviesRepository = MoviesRepositoryMock()
        
        homeMoviesViewModel = HomeMoviesViewModel(moviesRepository: moviesRepository)
    }

    override func tearDownWithError() throws {
        
    }
    
    func testLoadMoviesSuccess() async {
        let expectedMoviesCount = 20
        
        let moviesCount = homeMoviesViewModel.movies.count
        XCTAssertEqual(expectedMoviesCount, moviesCount)
    }
    
    func testLoadMoviesFailure() async {
        let expectedError = NSError(domain:"", code: 101, userInfo:nil)
    
        XCTAssertEqual(homeMoviesViewModel.state, .failed(expectedError))
    }
    
    func testHasMovies() async {
        await homeMoviesViewModel.loadMovies(page: 1)
        
        XCTAssertTrue(homeMoviesViewModel.hasMovies())
    }
    
    func testIdleState() {
        
    }
    
    func testLoadedState() async {
        await homeMoviesViewModel.loadMovies(page: 1)
        DispatchQueue.main.async {
            XCTAssertEqual(self.homeMoviesViewModel.state, .loaded)
        }
    }
}
