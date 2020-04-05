//
//  MyMoviesUITests.swift
//  MyMoviesUITests
//
//  Created by Wesley Brito on 02/04/20.
//  Copyright © 2020 Wesley Brito. All rights reserved.
//

import XCTest
@testable import MyMovies

class MyMoviesUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testAnimationView() {
        app.launch()
        XCTAssertTrue(app.otherElements["animationView"].exists)
    }
}
