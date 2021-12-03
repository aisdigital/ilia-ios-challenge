//
//  APIModelColorsTests.swift
//  Desafio 3(CII-3)Tests
//
//  Created by Guilherme Daniel Fernandes da Silva on 02/12/21.
//

import XCTest
import Moya
@testable import Desafio_3_CII_3_

class APIModelColorsTests: XCTestCase {
    
    // Test if the correct color is returned when the value is 5
    func testSelectColorYellow() {
        let selectData = MoviesAPI()
        
        let result = selectData.setTextColor(average: 5.0)
        XCTAssertEqual(result, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    }
    
    // Test if the correct color is returned when the value is 6.1
    func testSelectColorGreen() {
        let selectData = MoviesAPI()
        
        let result = selectData.setTextColor(average: 6.1)
        XCTAssertEqual(result, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
    }
    
    // Test if the correct color is returned when the value is 2.9
    func testSelectColorRed() {
        let selectData = MoviesAPI()
        
        let result = selectData.setTextColor(average: 2.9)
        XCTAssertEqual(result, #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1))
    }
}
