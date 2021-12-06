//
//  Desafio_3_CII_3_UITests.swift
//  Desafio 3(CII-3)UITests
//
//  Created by Guilherme Silva on 26/11/21.
//

import XCTest

class Desafio_3_CII_3_UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }
    
    // Tests scrooling though the screen
    func testScreenScroll() {
        let verticalScrollBar5PagesCollectionView = XCUIApplication()/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 5 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 5 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar5PagesCollectionView.swipeDown()
        verticalScrollBar5PagesCollectionView.swipeUp()
    }
    
    // Tests selecting a movie
    func testSelectMovie() {
        
        let app = XCUIApplication()
        let movie = app.collectionViews.children(matching:.any).element(boundBy: 2)
        if movie.exists {
             movie.tap()
        }
        app.navigationBars["Desafio_3_CII_3_.MovieDetailsView"].buttons["Movies"].tap()
        
        app.terminate()
    }
    
    // Tests navigating though pages
    func testNavigateThoughPages() {
                
        let moviesNavigationBar = XCUIApplication().navigationBars["Movies"]
        let nextButton = moviesNavigationBar.buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        
        let previousButton = moviesNavigationBar.buttons["Previous"]
        previousButton.tap()
        previousButton.tap()
        previousButton.tap()
        previousButton.tap()
        
        XCUIApplication().terminate()
        
    }
    
    // Tests selecting a movie after navigating though pages
    func testSelectAfterNavigating() {
        
        let app = XCUIApplication()

        let nextButton = app.navigationBars["Movies"].buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        let movie = app.collectionViews.children(matching:.any).element(boundBy: 3)
        if movie.exists {
             movie.tap()
        }
        let moviesButton = app.navigationBars["Desafio_3_CII_3_.MovieDetailsView"].buttons["Movies"]
        moviesButton.tap()
        
        app.terminate()
    }
    
    // This test select different movies after changing the screen
    func testSelectingDifferentMovies() {
        
        let app = XCUIApplication()
        let nextButton = app.navigationBars["Movies"].buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        
        var movie = app.collectionViews.children(matching:.any).element(boundBy: 3)
        if movie.exists {
             movie.tap()
        }
        
        let moviesButton = app.navigationBars["Desafio_3_CII_3_.MovieDetailsView"].buttons["Movies"]
        moviesButton.tap()
        movie = app.collectionViews.children(matching:.any).element(boundBy: 6)
        if movie.exists {
             movie.tap()
        }
        moviesButton.tap()
        
        app.terminate()

    }
    
    override func tearDown() {
        
    }

}
