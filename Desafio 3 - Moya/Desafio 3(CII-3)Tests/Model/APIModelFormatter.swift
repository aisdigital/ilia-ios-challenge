//
//  APIModelFormatter.swift
//  Desafio 3(CII-3)Tests
//
//  Created by Guilherme Daniel Fernandes da Silva on 02/12/21.
//

import XCTest
import Moya
@testable import Desafio_3_CII_3_

class APIModelFormatter: XCTestCase {
    // Test if the date is formatted correctely
    func testDateFormatter() {
        let getDateData = MoviesAPI()
        
        let result = getDateData.formatDate(date: "2002-10-01")
        XCTAssertEqual(result, "01/10/2002")
    }
}
