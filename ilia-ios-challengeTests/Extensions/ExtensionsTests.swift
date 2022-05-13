//
//  ExtensionsTests.swift
//  ilia-ios-challengeTests
//
//  Created by Joao Paulo on 11/04/22.
//

import XCTest
@testable import ilia_ios_challenge

class ExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateToFormattedString() {
        let expected = "11/04/2022"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "2022-04-11")
        
        XCTAssertEqual(expected, date?.toFormattedString())
    }
    
    func testStringToFormattedDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let expected = formatter.date(from: "2022-04-11")
        
        let dateString = "2022-04-11"
        
        XCTAssertEqual(expected, dateString.toFormattedDate())
    }
    
    func testWrongStringToFormattedDate() {
        let dateString = "11/04/2022"
        
        XCTAssertNil(dateString.toFormattedDate(dateFormat: "yyyy-MM-dd"))
    }
    
    func testUserDefaults() {
        let key = "keyTest"
        let object = "test"
        
        UserDefaults.standard.setCodableObject(object, forKey: key)
        let savedObject = UserDefaults.standard.codableObject(dataType: String.self, key: key)
        
        XCTAssertEqual(object, savedObject)
        
    }
    
}

