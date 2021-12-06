//
//  APIModelNetworkingTests.swift
//  Desafio 3(CII-3)Tests
//
//  Created by Guilherme Daniel Fernandes da Silva on 02/12/21.
//

import Moya
import XCTest
@testable import Desafio_3_CII_3_

class APIModelNetworkingTests: XCTestCase {
    
    // Test the time it takes to get data is acceptable
    func testFetchData() {
        let getData = MoviesController()
        
        let expectData = expectation(description: "Test loading data")
        getData.fetchData{
            expectData.fulfill()
        }
        wait(for: [expectData], timeout: 5)
    }
}
