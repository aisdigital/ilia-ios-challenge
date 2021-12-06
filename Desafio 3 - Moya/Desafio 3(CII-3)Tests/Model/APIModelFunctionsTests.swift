//
//  APIModelTests.swift
//  Desafio 3(CII-3)Tests
//
//  Created by Guilherme Daniel Fernandes da Silva on 02/12/21.
//

import XCTest
import Moya
@testable import Desafio_3_CII_3_

class APIModelFunctionsTests: XCTestCase {
    // Test if the URL image is set
    func testSetURLImageLink(){
        let data = MoviesController()
        
        let result = data.setImageLink(url: "h5UzYZquMwO9FVn15R2eK2itmHu.jpg")
        XCTAssertEqual(result, "https://image.tmdb.org/t/p/w342/h5UzYZquMwO9FVn15R2eK2itmHu.jpg")
    }
}
