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
        
        /*
         @INSERTION
         calling the load funtion to update the movies count
         */
        await homeMoviesViewModel.loadMovies()
        
        let moviesCount = homeMoviesViewModel.movies.count
        XCTAssertEqual(expectedMoviesCount, moviesCount)
    }
    
    func testLoadMoviesFailure() async {
        let expectedError = NSError(domain:"", code: 101, userInfo:nil)
        
        /*
         @INSERTION
         changing the variable to throw error and loading movies again to update the state
         */
        moviesRepository.isSuccess = false
        await homeMoviesViewModel.loadMovies()
    
        XCTAssertEqual(homeMoviesViewModel.state, .failed(expectedError))
    }
    
    func testHasMovies() async {
        /*
         @CHANGE
         change the function to the new signature
         */
        await homeMoviesViewModel.loadMovies()
        
        XCTAssertTrue(homeMoviesViewModel.hasMovies())
    }
    
    /*
     @CHANGE
     the following has been changed to check the idle state
     */
    func testIdleState() {
        XCTAssertEqual(homeMoviesViewModel.state, .idle)
    }
    
    func testLoadedState() async {
        /*
         @CHANGE
         change the function to the new signature
         */
        await homeMoviesViewModel.loadMovies()
        DispatchQueue.main.async {
            XCTAssertEqual(self.homeMoviesViewModel.state, .loaded)
        }
    }
}
