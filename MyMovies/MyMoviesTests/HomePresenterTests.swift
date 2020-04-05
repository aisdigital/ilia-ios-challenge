//
//  HomePresenterTests.swift
//  MyMoviesTests
//
//  Created by Wesley Brito on 05/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import XCTest
@testable import MyMovies

class HomePresenterTests: XCTestCase {

    var homePresenter: HomePresenter!
    
    override func setUp() {
        homePresenter = HomePresenter()
    }

    override func tearDown() {
        homePresenter = nil
        super.tearDown()
    }

    func testSearchTextCantBeNil() {
        XCTAssertTrue(homePresenter.searchTextIsValid(text: "Lion"))
    }
}
